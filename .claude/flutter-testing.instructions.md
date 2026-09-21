---
name: flutter-testing
description: "Use when: writing tests, improving test coverage, testing BLoCs/widgets, or debugging test failures. Ensures comprehensive test coverage and proper test patterns."
applyTo: ["test/**", "**/test/**"]
---

# Testing Guidelines

Comprehensive testing practices for the Flutter boilerplate.

## Test Structure

```
test/                          # Widget & integration tests
├── widget_test.dart
└── utils/
    └── test_utils.dart

core/test/                      # Core package tests
domain/test/                    # Domain layer tests
data/test/                      # Data layer tests
lib/features/my_feature/test/   # Feature-specific tests
```

## Test Hierarchy (Bottom-Up)

1. **Domain Tests** (entities, use cases) - No mocks needed
2. **Data Tests** (models, repositories, data sources) - Mock APIs
3. **Presentation Tests** (BLoCs, widgets) - Mock domain & data

## Mocking Convention: mockito, not mocktail

This project uses **`mockito`** with `@GenerateMocks` (code-generated via
`build_runner`) throughout — see any file in
`test/features/home/domain/usecases/` for the real pattern. It does **not**
use `mocktail`, and there is no `Either`/`Right`/`Left` (dartz) anywhere —
domain/data layers return `Result<T>` = `(T?, AppFailure?)`, a plain
record, from `core/lib/utils/network/result.dart`. The mockito/mocktail
API difference that matters most: mockito's `when(...)`/`verify(...)`
take the call directly, not wrapped in a closure (`when(() => ...)` is
mocktail's syntax).

## Unit Tests

### Testing Use Cases
```dart
// domain/usecases/my_usecase_test.dart
@GenerateMocks([MyRepository])
void main() {
  late MockMyRepository mockRepository;
  late GetMyDataUseCase useCase;

  setUp(() {
    mockRepository = MockMyRepository();
    useCase = GetMyDataUseCase(mockRepository);
  });

  test('should get data from repository', () async {
    final tData = TestData.myEntity;
    when(mockRepository.getData()).thenAnswer((_) async => (tData, null));

    final (data, error) = await useCase();

    expect(data, tData);
    expect(error, isNull);
    verify(mockRepository.getData()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    const tFailure = NetworkFailure(message: 'Server error');
    when(mockRepository.getData()).thenAnswer((_) async => (null, tFailure));

    final (data, error) = await useCase();

    expect(data, isNull);
    expect(error, tFailure);
  });
}
```
Run `fvm flutter pub run build_runner build` after adding/changing
`@GenerateMocks` to produce the matching `*_test.mocks.dart` file.

### Testing Repositories
```dart
// data/repositories/my_repository_impl_test.dart
@GenerateMocks([MyRemoteDataSource])
void main() {
  late MockMyRemoteDataSource mockRemoteDataSource;
  late MyRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMyRemoteDataSource();
    repository = MyRepositoryImpl(remoteDatasource: mockRemoteDataSource);
  });

  group('getData', () {
    test('should return remote data', () async {
      const tModel = MyModel(id: '1', name: 'Test');
      when(mockRemoteDataSource.getData())
          .thenAnswer((_) async => [tModel]);

      final (data, error) = await repository.getData();

      expect(data, [tModel]);
      expect(error, isNull);
    });

    test('should return failure on exception', () async {
      when(mockRemoteDataSource.getData())
          .thenThrow(const SocketException('Network error'));

      final (data, error) = await repository.getData();

      expect(data, isNull);
      expect(error, isNotNull);
    });
  });
}
```

## Cubit Tests

`bloc_test` is **not currently a dependency** in this project (it was
dropped early on for a `bloc` 7.x conflict; `bloc` is on 9.x now, so
adding it is unblocked if you want the `blocTest<>()` helper). Without it,
drive the Cubit directly and assert on its `.stream`:
```dart
// presentation/cubit/my_cubit_test.dart
@GenerateMocks([GetMyDataUseCase])
void main() {
  late MockGetMyDataUseCase mockGetMyDataUseCase;
  late MyCubit myCubit;

  setUp(() {
    mockGetMyDataUseCase = MockGetMyDataUseCase();
    myCubit = MyCubit(getMyDataUseCase: mockGetMyDataUseCase);
  });

  tearDown(() => myCubit.close());

  test('initial state is MyInitial', () {
    expect(myCubit.state, const MyInitial());
  });

  test('emits [loading, loaded] when fetchData succeeds', () async {
    final tData = [TestData.myEntity];
    when(mockGetMyDataUseCase())
        .thenAnswer((_) async => (tData, null));

    final states = <MyState>[];
    final sub = myCubit.stream.listen(states.add);
    await myCubit.fetchData();
    await sub.cancel();

    expect(states, [const MyLoading(), MyLoaded(data: tData)]);
  });
}
```

## Widget Tests

### Testing Pages/Widgets
```dart
// presentation/pages/my_page_test.dart
@GenerateMocks([MyCubit])
void main() {
  late MockMyCubit mockMyCubit;

  setUp(() {
    mockMyCubit = MockMyCubit();
  });

  testWidgets('displays loading indicator', (WidgetTester tester) async {
    when(mockMyCubit.state).thenReturn(const MyLoading());
    when(mockMyCubit.stream)
        .thenAnswer((_) => Stream.value(const MyLoading()));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MyCubit>.value(
          value: mockMyCubit,
          child: const MyPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```
Note: mocking a `Cubit`/`Bloc` with `mockito` needs its `.stream` stubbed
too (`BlocBuilder` subscribes to it), not just `.state` — that's easy to
forget and get a widget test that silently never rebuilds.

## Test Data & Fixtures

Create reusable test data (see the real, if currently unused,
`test/utils/test_utils.dart` for the pattern already in this repo):

```dart
class TestData {
  static const myEntity = MyEntity(id: '1', name: 'Test Name');
  static const myModel = MyModel(id: '1', name: 'Test Name');
  static final myDataList = [myEntity, myEntity];

  static Map<String, dynamic> myJson() => {'id': '1', 'name': 'Test Name'};
}
```

## Testing Best Practices

### Do's ✅
- Write tests for critical business logic first
- Use descriptive test names
- Follow Arrange-Act-Assert pattern
- Test one thing per test
- Use test fixtures for consistency
- Mock external dependencies
- Verify interactions (verify, verifyNoMoreInteractions)
- Test edge cases and error paths

### Don'ts ❌
- Don't test implementation details
- Don't mix multiple concerns in one test
- Don't make tests dependent on each other
- Don't test third-party libraries
- Don't ignore flaky tests
- Don't test everything equally

## Running Tests

```bash
# Run all tests
fvm flutter test

# Run tests in verbose mode
fvm flutter test --verbose

# Run specific file
fvm flutter test test/widget_test.dart

# Run with coverage
fvm flutter test --coverage

# Run matching pattern
fvm flutter test --name="should"

# Stop on first failure
fvm flutter test -x
```

## Coverage Goals

- **Domain layer**: 80%+ coverage
- **Data layer**: 70%+ coverage
- **Presentation layer**: 60%+ coverage
- **Overall**: Minimum 70% for new code

## Test Naming Convention

Use descriptive names:

✅ **Good:**
- `should_return_success_when_data_is_valid`
- `emits_loading_then_success_when_fetch_succeeds`
- `displays_error_message_on_failure`

❌ **Bad:**
- `test1`
- `testSuccess`
- `dataTest`

## Debugging Tests

```dart
// Print debug info
test('my test', () {
  debugPrint('Debug message: $variable');
  expect(value, expected);
});

// Use tester.pump for timing issues
await tester.pump();
await tester.pump(Duration(milliseconds: 500));

// Find by key
expect(find.byKey(Key('myWidget')), findsOneWidget);

// Get widget
final widget = find.byType(Text);
expect(widget, findsOneWidget);
```

## Continuous Integration

**There is no CI configured** — no `.github/workflows` directory exists.
Tests only run when someone runs `fvm flutter test` locally. See
`README.md`'s Advanced Patterns section for a starting GitHub Actions
workflow if you want to add one.

