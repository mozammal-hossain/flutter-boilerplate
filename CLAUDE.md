# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**flutter_boilerplate** is a production-ready Flutter application using Clean Architecture with feature-based organization. It demonstrates best practices for state management (BLoC), dependency injection, networking, and local storage.

**Key Stack:**
- **Flutter 3.41.8** (managed by FVM in `.fvmrc`, bundles Dart 3.11.5)
- **State Management:** BLoC 9.x (the one real feature uses Cubit, not Bloc+events)
- **Architecture:** Clean Architecture (presentation/domain/data layers)
- **Dependency Injection:** GetIt + Injectable
- **Networking:** Dio + Retrofit
- **Local Storage:** Hive CE + SharedPreferences (`hive_ce`, the maintained fork — not the abandoned `hive` package)
- **Navigation:** go_router
- **Code Generation:** build_runner, freezed, json_serializable

## Project Structure

### Monorepo Organization

The project uses a monorepo structure with separate packages:

```
flutter_boilerplate/           # Main app
├── lib/
│   ├── main.dart              # Entry point
│   ├── feature_home/          # Feature (presentation layer only)
│   │   ├── cubit/            # BLoC/Cubit for state management
│   │   ├── pages/            # Full-screen widgets
│   │   └── widgets/          # Reusable components
│   ├── routes/               # Navigation config (go_router)
│   └── src/
│       ├── injection/        # DI setup wrapper
│       └── ...
│
├── core/                      # Shared utilities package
│   ├── lib/utils/
│   │   ├── network/          # HTTP client, interceptors (dio)
│   │   ├── storage/          # Local storage wrappers
│   │   ├── theme/            # App theme & styles
│   │   ├── failure/          # Error handling (sealed classes)
│   │   ├── injection/        # DI configuration
│   │   └── logger/           # Logging setup
│   └── pubspec.yaml
│
├── domain/                    # Business logic package
│   └── feature_home/
│       ├── entities/         # Data models
│       ├── repositories/     # Abstract interfaces
│       └── usecases/         # Business logic
│
├── data/                      # Data access package
│   └── feature_home/
│       ├── datasources/      # Remote/local data sources
│       ├── models/           # JSON models
│       └── repositories/     # Concrete implementations
│
└── test/                      # Shared test utilities
```

### Architecture Layers

**Domain Layer** (`domain/` package)
- Pure business logic, no dependencies on Flutter
- Entities: immutable data models
- Repository interfaces: abstract contracts
- Use cases: single responsibility business operations
- Returns `Future<Result<T>>`, where `Result<T> = (T?, AppFailure?)` — a
  positional record, not `Either`/dartz (this project doesn't depend on
  `dartz`). See `core/lib/utils/network/result.dart`.

**Data Layer** (`data/` package)
- Implements domain repositories
- Data sources: remote (Dio) and local (Hive/SharedPreferences)
- Models: extend entities with JSON serialization
- Handles error-to-failure mapping

**Presentation Layer** (`lib/feature_*/`)
- BLoC/Cubit for state management
- Pages: full-screen widgets with BlocProvider
- Widgets: reusable UI components
- UI state sealed classes (Loading/Success/Failure)

**Core Layer** (`core/` package)
- Shared utilities across layers
- Network setup: interceptors, clients, serialization
- Storage: Hive, SharedPreferences wrappers
- Theme, constants, extensions, failure types
- Dependency injection configuration

## Essential Commands

**Always use FVM** — never run `flutter` directly:

```bash
# Get dependencies (run after changes to pubspec.yaml)
fvm flutter pub get

# Format code
fvm dart format .

# Analyze for type/lint issues
fvm flutter analyze

# Run tests
fvm flutter test                          # All tests
fvm flutter test test/features/home/      # Single directory
fvm flutter test -x                       # Stop on first failure
fvm flutter test --coverage               # Generate coverage report

# Run app
fvm flutter run                           # Debug
fvm flutter run --release                 # Release mode
fvm flutter run -d web                    # Web platform

# Build for release
fvm flutter build apk --release           # Android APK
fvm flutter build appbundle --release     # Android App Bundle
fvm flutter build ios --release           # iOS
fvm flutter build web --release           # Web

# Code generation (run after modifying models, freezed, json_serializable)
fvm flutter pub run build_runner build        # Build once
fvm flutter pub run build_runner watch       # Watch for changes
fvm flutter pub run build_runner clean       # Remove generated files

# Before committing
fvm dart format .
fvm flutter analyze
fvm flutter test
```

## Feature Development Workflow

Each feature follows Clean Architecture with three packages:

### 1. Domain Layer (`domain/lib/feature_X/`)

**Entity** — Immutable data model:
```dart
class MyEntity extends Equatable {
  final String id;
  const MyEntity({required this.id});
  @override
  List<Object?> get props => [id];
}
```

**Repository Interface** — Abstract contract:
```dart
abstract class MyRepository {
  Future<Result<MyEntity>> getData();
}
```

**Use Case** — Single business operation (see `domain/lib/feature_home/usecases/`
for the real pattern — a callable class, not a `UseCase<T, Params>` base class):
```dart
@injectable
class GetDataUseCase {
  const GetDataUseCase(this._repository);
  final MyRepository _repository;

  Future<Result<MyEntity>> call() => _repository.getData();
}
```

### 2. Data Layer (`data/lib/feature_X/`)

**Model** — Extends entity with JSON serialization:
```dart
class MyModel extends MyEntity {
  const MyModel({required String id}) : super(id: id);
  
  factory MyModel.fromJson(Map<String, dynamic> json) =>
    MyModel(id: json['id']);
  
  Map<String, dynamic> toJson() => {'id': id};
}
```

**Data Source** — Access remote/local data:
```dart
abstract class MyRemoteDataSource {
  Future<MyModel> getData();
}

class MyRemoteDataSourceImpl implements MyRemoteDataSource {
  final Dio dio;
  MyRemoteDataSourceImpl(this.dio);
  
  @override
  Future<MyModel> getData() async {
    final response = await dio.get('/api/data');
    return MyModel.fromJson(response.data);
  }
}
```

**Repository Implementation** — Bridges domain and data:
```dart
@LazySingleton(as: MyRepository)
class MyRepositoryImpl implements MyRepository {
  MyRepositoryImpl({required this.remoteDataSource});
  final MyRemoteDataSource remoteDataSource;

  @override
  Future<Result<MyEntity>> getData() async {
    try {
      final data = await remoteDataSource.getData();
      return (data.toEntity(), null);
    } on DioException catch (e) {
      return (null, NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e, st) {
      return (null, UnknownFailure(message: '$e', exception: e, stackTrace: st));
    }
  }
}
```

### 3. Presentation Layer (`lib/feature_X/`)

The real `home_cubit.dart` uses **Cubit** (no events) with a `@freezed`
union state — not `Bloc<Event, State>` with hand-rolled `Equatable` states.
`core/lib/utils/base/base_bloc.dart` (a `Bloc<E, S>` + events base class)
exists but isn't used by the Home feature; prefer the Cubit pattern below
unless a feature genuinely needs event-sourcing.

**State** — `@freezed` union (no events needed):
```dart
@freezed
class MyState with _$MyState {
  const factory MyState.initial() = MyInitial;
  const factory MyState.loading() = MyLoading;
  const factory MyState.loaded({required MyEntity data}) = MyLoaded;
  const factory MyState.error({required String message}) = MyError;
}
```

**Cubit**:
```dart
@injectable
class MyCubit extends Cubit<MyState> {
  MyCubit({required GetDataUseCase getDataUseCase})
    : _getDataUseCase = getDataUseCase,
      super(const MyInitial());

  final GetDataUseCase _getDataUseCase;

  Future<void> fetchData() async {
    emit(const MyState.loading());
    final (data, error) = await _getDataUseCase();
    if (data != null) {
      emit(MyState.loaded(data: data));
    } else if (error != null) {
      emit(MyState.error(message: error.message));
    }
  }
}
```

**Page** — Full-screen widget:
```dart
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyCubit>()..fetchData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Feature')),
        body: BlocBuilder<MyCubit, MyState>(
          builder: (context, state) => state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (data) => ListView(children: [Text(data.id)]),
            error: (message) => Center(child: Text(message)),
          ),
        ),
      ),
    );
  }
}
```

### 4. Dependency Injection Setup

Annotate classes directly — `@injectable` for a plain factory,
`@LazySingleton(as: MyRepository)` when a class implements an interface:

```dart
@injectable
class MyCubit extends Cubit<MyState> { ... }        // in lib/ (app)

@LazySingleton(as: MyRepository)
class MyRepositoryImpl implements MyRepository { ... }  // in data/lib/

@injectable
class GetDataUseCase { ... }                        // in domain/lib/
```

**Important — this is not one shared config file.** Each package
(`core`, `domain`, `data`, and the app's own `lib/`) generates its own DI
config, because each has its own `@InjectableInit()` entry point:
- `core/lib/utils/injection/di.dart` → `di.config.dart` (core's `DIModule`,
  `ApiClient`, `LocalStorage`)
- `domain/lib/injection.dart` → `injection.config.dart`
- `data/lib/injection.dart` → `injection.config.dart`
- `lib/src/injection/app_injection.dart` → `app_injection.config.dart`

`lib/src/injection/di.dart` composes all four generated `init*()` calls
(`initDomain`, `initData`, `initApp`, plus core's own `init`) into one
`configureDependencies()` — that's the only place they're wired together.
**A new `@injectable`/`@LazySingleton` class in `domain/`, `data/`, or `lib/`
is invisible to GetIt until you rebuild in that package** (see below) —
this bit the project once already (a Cubit and its whole dependency chain
were annotated but never actually registered, so the app crashed at
runtime with `GetIt: Object/factory with type X is not registered`, even
though `flutter analyze`/`flutter test` were clean).

After adding/changing `@injectable` annotations, rebuild **in the package
you edited** (running only from the root does not regenerate `core/`,
`domain/`, or `data/`'s own config):
```bash
cd domain && fvm flutter pub run build_runner build --delete-conflicting-outputs
cd ../data && fvm flutter pub run build_runner build --delete-conflicting-outputs
cd ../core && fvm flutter pub run build_runner build --delete-conflicting-outputs
cd .. && fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Key Patterns & Conventions

### Result Type (`Result<T>` — not `Either`/dartz)
This project does **not** depend on `dartz`. Use `Result<T>` — a
`typedef Result<T> = (T?, AppFailure?)` positional record, defined in
`core/lib/utils/network/result.dart` — for domain/data layer returns
to represent success/failure without exceptions:

```dart
// Domain use case
Future<Result<List<Post>>> getPosts();

// In Cubit
final (posts, error) = await getPosts();
if (posts != null) {
  emit(MyState.loaded(data: posts));
} else if (error != null) {
  emit(MyState.error(message: error.message));
}
```

Custom failure types live in `core/lib/utils/failure/app_failure.dart`
(there is no `ServerFailure` — use these):
- `NetworkFailure` — HTTP/connection errors
- `CacheFailure` — Local storage errors
- `ValidationFailure` — Input validation
- `AuthFailure` — Auth/authorization errors
- `UnknownFailure` — Unexpected errors
- Add domain-specific failures as needed

### Sealed Unions for Type Safety
States and failures are exhaustive unions. The real code uses `@freezed`
classes with a `with _$X` mixin and multiple `const factory` constructors
(see `lib/home/cubit/home_cubit.dart`'s `HomeState`), not Dart's `sealed`
keyword directly — `state.when(...)` gives the same compiler-enforced
exhaustiveness as a switch over a `sealed class` would.
Failures (`core/lib/utils/failure/app_failure.dart`) are an
`abstract class AppFailure implements Exception` hierarchy
(`NetworkFailure`, `CacheFailure`, `ValidationFailure`, `AuthFailure`,
`UnknownFailure`).

### Equatable for Equality
Use `Equatable` for immutable data models to avoid manual `==` implementation:
```dart
class MyEntity extends Equatable {
  final String id;
  const MyEntity({required this.id});
  
  @override
  List<Object?> get props => [id];  // Compare by these props
}
```

### Cubit vs. Bloc
The real feature uses **Cubit**: call a method (e.g. `fetchHomeData()`),
`emit()` states directly — no event classes, no `on<EventType>(_handler)`.
Reach for `Bloc<Event, State>` (`core/lib/utils/base/base_bloc.dart` has an
unused `BaseBloc` you can extend) only if a feature genuinely needs
event-sourcing/replay. Either way: always emit the initial state in the
constructor, and use `Emitter` to emit multiple states in sequence within
one handler.

### Error Handling
Never use `try-catch` in domain/presentation layers when returning
`Result<T>`. Catch at the data layer:

```dart
// ❌ Don't do this — domain/presentation should stay exception-free
Future<Result<T>> getData() async {
  try {
    return (await remoteDataSource.getData(), null);
  } catch (e) {
    return (null, UnknownFailure(message: '$e'));
  }
}

// ✅ Do this in data layer, let domain be pure
@override
Future<Result<T>> getData() async {
  try {
    return (await remoteDataSource.getData(), null);
  } on DioException catch (e) {
    return (null, NetworkFailure(message: e.message ?? 'Network error'));
  } catch (e, st) {
    return (null, UnknownFailure(message: '$e', exception: e, stackTrace: st));
  }
}
```

## Network & Storage

### Dio Configuration
Configured in `core/lib/utils/network/` with:
- **AuthInterceptor** — Adds Bearer tokens to requests
- **LoggingInterceptor** — Logs HTTP requests/responses
- **Retrofit** — Type-safe API clients (generate with `build_runner`)

### Local Storage
Access via `getIt<LocalStorage>()`:
```dart
final storage = getIt<LocalStorage>();

// Save
await storage.set('key', 'value');

// Retrieve
final (value, _) = await storage.get<String>('key');

// Delete
await storage.delete('key');
```

Persists to:
- **Hive** — Structured data (models)
- **SharedPreferences** — Simple key-value pairs

## Testing

Mocking uses **`mockito`** with `@GenerateMocks` (code-generated `.mocks.dart`
files via `build_runner`) — **not** `mocktail`. `bloc_test` is not a
dependency either (adding it is now unblocked since `bloc` is on 9.x, but
no cubit tests exist yet — see Known Gaps below).

Actual current test structure — `test/features/*/presentation/` and
`test/features/*/data/repositories/` don't exist yet, only what's listed:
```
test/
├── core/
│   └── error_boundary/error_boundary_test.dart
├── features/
│   └── home/
│       ├── domain/{usecases,entities}/
│       └── data/models/
├── utils/test_utils.dart
└── widget_test.dart
```

### Unit Test (Use Case) — real pattern from
`test/features/home/domain/usecases/get_home_data_usecase_test.dart`:
```dart
@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockRepository;
  late GetHomeDataUseCase usecase;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetHomeDataUseCase(mockRepository);
  });

  test('returns data on success', () async {
    when(mockRepository.getHomeData())
        .thenAnswer((_) async => (tHomeEntity, null));

    final (data, error) = await usecase();

    expect(data, equals(tHomeEntity));
    expect(error, isNull);
    verify(mockRepository.getHomeData()).called(1);
  });
}
```
Run `fvm flutter pub run build_runner build` after adding `@GenerateMocks`
to produce the matching `*_test.mocks.dart` file.

### Cubit Test
No `bloc_test` dependency yet, so drive the Cubit directly and assert on
its `.stream`/`.state`:
```dart
@GenerateMocks([GetHomeDataUseCase, GetHomeDetailUseCase])
void main() {
  test('emits [loading, loaded] on fetchHomeData success', () async {
    final mockGetData = MockGetHomeDataUseCase();
    when(mockGetData(forceRefresh: anyNamed('forceRefresh')))
        .thenAnswer((_) async => (tHomeEntity, null));
    final cubit = HomeCubit(
      getHomeDataUseCase: mockGetData,
      getHomeDetailUseCase: MockGetHomeDetailUseCase(),
    );

    final states = <HomeState>[];
    final sub = cubit.stream.listen(states.add);
    await cubit.fetchHomeData();
    await sub.cancel();

    expect(states, [const HomeLoading(), isA<HomeLoaded>()]);
  });
}
```

### Widget Test
```dart
void main() {
  testWidgets('HomePage renders list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HomeCubit>(
          create: (_) => mockCubit,
          child: const HomePage(),
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
  });
}
```

### Known Gaps
No cubit, repository, or widget tests exist for the Home feature yet —
only use cases, entities, and models are covered (see `README.md`'s
Status section for the current count).

## Code Generation

Several packages require code generation. After modifying these files, run:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Watches for changes and rebuilds automatically:
```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

### Packages Using Code Generation

| File | Generator | Output |
|------|-----------|--------|
| `*.freezed.dart` | Freezed | Immutable value types |
| `*.g.dart` | json_serializable | JSON serialization |
| `*.config.dart` | injectable | DI registration |
| `*.retrofit.dart` | retrofit | Retrofit client |
| `*.hive.dart` | hive_generator | Hive adapters |

## Common Tasks

### Add a New Feature
```bash
# Use the create-feature skill (if available) or:
# 1. Create domain/lib/feature_x/ with entities, repositories, usecases
# 2. Create data/lib/feature_x/ with models, datasources, repository_impl
# 3. Create lib/feature_x/ with cubit, pages, widgets
# 4. Register in core DI (di.config.dart)
# 5. Add routes in lib/routes/app_router.dart

fvm flutter pub run build_runner build
fvm flutter analyze
fvm flutter test
```

### Fix Type Safety Issues
If you see warnings like "type arguments should be explicit", add `<dynamic>` or the specific type:

```dart
// ❌ Implicit dynamic
final response = await Dio().fetch(options);

// ✅ Explicit type
final response = await Dio().fetch<dynamic>(options);
```

### Update a Dependency
```bash
# Add new package
fvm flutter pub add package_name

# Update existing
fvm flutter pub upgrade package_name

# Update all
fvm flutter pub upgrade

# Then test
fvm flutter pub get
fvm flutter analyze
fvm flutter test
```

### Run Tests with Coverage
```bash
fvm flutter test --coverage
open coverage/lcov.html  # View report on macOS
```

### Clean Build Cache
```bash
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner clean
fvm flutter pub run build_runner build
```

## Debugging

### Enable Debug Logging
`AppLogger` (`core/lib/utils/logger/app_logger.dart`) is a static wrapper
around `package:logger`; there's no free-floating `setLogLevel()` function:
```dart
AppLogger.init(level: Level.debug, enable: true);
```

### BLoC Observer
`SimpleBlocObserver` (`core/lib/utils/bloc_observer.dart`) is registered as
`Bloc.observer` in `main.dart` and logs create/change/error/close events
for every Bloc and Cubit. Check console output during `fvm flutter run`.

### Hot Reload
Press `r` in terminal during `fvm flutter run` to hot reload (preserves app state).
Press `R` to hot restart (restarts app, clears state).

### Slow Build?
Use `--split-debug-info` to speed up debug builds (slower startup):
```bash
fvm flutter run --split-debug-info
```

## Important Notes

### FVM is Required
This project pins Flutter to **3.41.8** in `.fvmrc`. Commands like `fvm flutter` respect this version; bare `flutter` might use a different version installed locally.

### Monorepo Structure
`core/`, `data/`, and `domain/` are separate packages referenced in main `pubspec.yaml` via path dependencies. Run `fvm flutter pub get` in root to sync all packages.

### Avoid These Patterns
- ❌ Accessing data layer directly from UI
- ❌ Circular dependencies between packages — **currently violated**:
  `core/pubspec.yaml` path-depends on `data` and `domain`, which both
  path-depend back on `core`. It resolves today only because no file
  actually imports in a cycle; don't add a new one that does, and prefer
  fixing this (e.g. move `core`'s feature-specific DI wiring for
  `HomeRemoteDatasource` out of `DIModule`) over extending it.
- ❌ Using `BuildContext` across `await` boundaries
- ❌ Mutable state in entities/models
- ❌ Exception-based error handling in domain layer (use `Result<T>`)
- ❌ Calling `getIt` inside stateless widgets — use `BlocProvider` instead

### Good Practices
- ✅ Use sealed classes for exhaustive checks
- ✅ Use `Equatable` for value comparison
- ✅ Register factories (not singletons) for BLoCs
- ✅ Write tests for use cases and BLoCs
- ✅ Document complex business logic with doc comments
- ✅ Use meaningful names (prefer `LoadPostsEvent` over `Event1`)

## References

- **Flutter Docs:** https://flutter.dev
- **BLoC Pattern:** https://bloclibrary.dev
- **Effective Dart:** https://dart.dev/guides/language/effective-dart
- **FVM:** https://fvm.app
- **Clean Architecture:** https://resocoder.com/clean-architecture-tdd

For detailed file-level instructions, see `.claude/` directory:
- `flutter-feature-development.instructions.md` — Feature structure & BLoC patterns
- `flutter-build-files.instructions.md` — pubspec.yaml & build config
- `flutter-testing.instructions.md` — Testing patterns & mocking
- `copilot-instructions.md` — Project-wide conventions
