---
name: flutter-feature-development
description: "Use when: working in lib/features/ directory, implementing new features, or modifying existing feature modules. Ensures architecture consistency and BLoC pattern adherence."
applyTo: ["lib/features/**"]
---

# Feature Development

Guidelines for working in the `lib/features/` directory.

## Feature Structure

Each feature must follow clean architecture with three layers:

```
lib/features/my_feature/
├── presentation/         # UI & State Management (BLoC)
│   ├── bloc/
│   │   ├── my_feature_bloc.dart      # BLoC class
│   │   ├── my_feature_event.dart     # Events (inputs)
│   │   └── my_feature_state.dart     # States (outputs)
│   ├── pages/
│   │   └── my_feature_page.dart      # Full screen widgets
│   └── widgets/
│       └── my_custom_widget.dart     # Reusable widgets
│
├── domain/               # Business Logic (independent of UI/data)
│   ├── entities/
│   │   └── my_entity.dart            # Data models
│   ├── repositories/
│   │   └── my_feature_repository.dart # Interface (abstract)
│   └── usecases/
│       └── get_my_data_usecase.dart  # Business logic
│
└── data/                 # Data Access Layer
    ├── datasources/
    │   ├── my_feature_local_datasource.dart
    │   └── my_feature_remote_datasource.dart
    ├── models/
    │   └── my_feature_model.dart     # JSON/data model
    └── repositories/
        └── my_feature_repository_impl.dart
```

## BLoC Pattern

### Events (User Actions)
```dart
// my_feature_event.dart
sealed class MyFeatureEvent extends Equatable {
  const MyFeatureEvent();
}

final class LoadMyDataEvent extends MyFeatureEvent {
  const LoadMyDataEvent();
  
  @override
  List<Object?> get props => [];
}
```

### States (UI Updates)
```dart
// my_feature_state.dart
sealed class MyFeatureState extends Equatable {
  const MyFeatureState();
}

final class MyFeatureInitial extends MyFeatureState {
  @override
  List<Object?> get props => [];
}

final class MyFeatureLoading extends MyFeatureState {
  @override
  List<Object?> get props => [];
}

final class MyFeatureSuccess extends MyFeatureState {
  final List<MyEntity> data;
  const MyFeatureSuccess(this.data);
  
  @override
  List<Object?> get props => [data];
}

final class MyFeatureFailure extends MyFeatureState {
  final String message;
  const MyFeatureFailure(this.message);
  
  @override
  List<Object?> get props => [message];
}
```

### BLoC Class
```dart
// my_feature_bloc.dart
class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
  final GetMyDataUseCase getMyDataUseCase;
  
  MyFeatureBloc({required this.getMyDataUseCase})
      : super(const MyFeatureInitial()) {
    on<LoadMyDataEvent>(_onLoadMyData);
  }
  
  Future<void> _onLoadMyData(
    LoadMyDataEvent event,
    Emitter<MyFeatureState> emit,
  ) async {
    emit(const MyFeatureLoading());
    final result = await getMyDataUseCase();
    result.fold(
      (failure) => emit(MyFeatureFailure(failure.message)),
      (data) => emit(MyFeatureSuccess(data)),
    );
  }
}
```

## Domain Layer

### Entity (Data Model)
```dart
// domain/entities/my_entity.dart
class MyEntity extends Equatable {
  final String id;
  final String name;
  
  const MyEntity({
    required this.id,
    required this.name,
  });
  
  @override
  List<Object?> get props => [id, name];
}
```

### Repository Interface
```dart
// domain/repositories/my_feature_repository.dart
// Result<T> = (T?, AppFailure?), not Either<Failure, T> — this project
// doesn't depend on dartz. See core/lib/utils/network/result.dart.
abstract class MyFeatureRepository {
  Future<Result<List<MyEntity>>> getMyData();
}
```

### Use Case
```dart
// domain/usecases/get_my_data_usecase.dart
// Real use cases here are plain callable classes, not a UseCase<T, Params>
// base class (there isn't one) — see domain/lib/feature_home/usecases/.
@injectable
class GetMyDataUseCase {
  const GetMyDataUseCase(this._repository);
  final MyFeatureRepository _repository;

  Future<Result<List<MyEntity>>> call() => _repository.getMyData();
}
```

## Data Layer

### Model
```dart
// data/models/my_feature_model.dart
class MyModel extends MyEntity {
  const MyModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);
  
  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json['id'],
      name: json['name'],
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
```

### Data Sources
```dart
// data/datasources/my_feature_remote_datasource.dart
abstract class MyFeatureRemoteDataSource {
  Future<List<MyModel>> getMyData();
}

class MyFeatureRemoteDataSourceImpl implements MyFeatureRemoteDataSource {
  final Dio dio;
  
  MyFeatureRemoteDataSourceImpl(this.dio);
  
  @override
  Future<List<MyModel>> getMyData() async {
    final response = await dio.get('/api/data');
    return (response.data as List)
        .map((e) => MyModel.fromJson(e))
        .toList();
  }
}
```

### Repository Implementation
```dart
// data/repositories/my_feature_repository_impl.dart
@LazySingleton(as: MyFeatureRepository)
class MyFeatureRepositoryImpl implements MyFeatureRepository {
  MyFeatureRepositoryImpl({required this.remoteDataSource});
  final MyFeatureRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<MyEntity>>> getMyData() async {
    try {
      final data = await remoteDataSource.getMyData();
      return (data, null);
    } on DioException catch (e) {
      return (null, NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e, st) {
      return (null, UnknownFailure(message: '$e', exception: e, stackTrace: st));
    }
  }
}
```
Note: `AppFailure` has no `ServerFailure` class — use `NetworkFailure`,
`CacheFailure`, `ValidationFailure`, `AuthFailure`, or `UnknownFailure`
(`core/lib/utils/failure/app_failure.dart`).

## UI Layer

### Page
```dart
// presentation/pages/my_feature_page.dart
class MyFeaturePage extends StatelessWidget {
  const MyFeaturePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyFeatureBloc>()..add(const LoadMyDataEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Feature')),
        body: BlocBuilder<MyFeatureBloc, MyFeatureState>(
          builder: (context, state) {
            if (state is MyFeatureLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MyFeatureSuccess) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.data[index].name),
                  );
                },
              );
            }
            if (state is MyFeatureFailure) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
```

## Dependency Injection Setup

Register in `lib/src/injection/injection_container.dart`:

```dart
void setupMyFeatureInjection() {
  // Data sources
  getIt.registerSingleton<MyFeatureRemoteDataSource>(
    MyFeatureRemoteDataSourceImpl(getIt<Dio>()),
  );
  
  // Repository
  getIt.registerSingleton<MyFeatureRepository>(
    MyFeatureRepositoryImpl(remoteDataSource: getIt()),
  );
  
  // Use cases
  getIt.registerSingleton<GetMyDataUseCase>(
    GetMyDataUseCase(getIt()),
  );
  
  // BLoC
  getIt.registerFactory<MyFeatureBloc>(
    () => MyFeatureBloc(getMyDataUseCase: getIt()),
  );
}
```

## Testing

### Unit Test Example
Uses `mockito` + `@GenerateMocks` (this project's actual convention — not
`mocktail`, which doesn't take a closure in `when()`):
```dart
// test/features/my_feature/domain/usecases/get_my_data_usecase_test.dart
@GenerateMocks([MyFeatureRepository])
void main() {
  late MockMyFeatureRepository mockRepository;
  late GetMyDataUseCase useCase;

  setUp(() {
    mockRepository = MockMyFeatureRepository();
    useCase = GetMyDataUseCase(mockRepository);
  });

  test('should get data from repository', () async {
    final tData = [const MyEntity(id: '1', name: 'Test')];
    when(mockRepository.getMyData()).thenAnswer((_) async => (tData, null));

    final (data, error) = await useCase();

    expect(data, tData);
    expect(error, isNull);
    verify(mockRepository.getMyData()).called(1);
  });
}
```
Run `fvm flutter pub run build_runner build` after adding `@GenerateMocks`
to generate `get_my_data_usecase_test.mocks.dart`.

## Before Committing

```bash
fvm dart format lib/features/my_feature
fvm flutter analyze
fvm flutter test
```

## Don't Forget

- ✅ Use `Equatable` for equality comparison
- ✅ Use `sealed` classes for type safety
- ✅ Document public APIs with doc comments (`///`)
- ✅ Handle all error cases
- ✅ Write tests for use cases and BLoCs
- ✅ Register in dependency injection
- ✅ Use meaningful names
- ❌ Don't create circular dependencies
- ❌ Don't access data layer from UI directly
- ❌ Don't use BuildContext across async gaps

