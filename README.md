# flutter_boilerplate

A Clean Architecture Flutter starting point — feature-based, BLoC/Cubit
state management, DI via `injectable`. One real feature (Home) is built
out end-to-end as a worked example; see
[Known Limitations](#known-limitations) before treating this as
production-ready as-is.

## Why Use This?

**Problem:** Most Flutter projects grow messy. Business logic bleeds into UI, navigation breaks, testing becomes impossible, code reuse fails.

**Solution:** This boilerplate demonstrates Clean Architecture layer
separation, built out for one real feature (Home):
- **Feature isolation** — Each feature spans domain/data/presentation packages
- **Testable** — Business logic decoupled from UI, mockable dependencies
- **Type-safe** — `@freezed` union states, exhaustive `.when()` matching
- **Some production patterns wired up** — error boundary, caching, app
  flavors. Not yet: auth guards, CI (see [Known Limitations](#known-limitations))

## Key Stack

| Layer | Tool | Why |
|-------|------|-----|
| **State** | BLoC 9.x (Cubit, not Bloc+events, for the real feature) | Reactive, testable |
| **Nav** | go_router | Type-safe, deep-linking-ready (auth guard params exist but aren't wired to a redirect yet) |
| **Network** | Dio + Retrofit | Interceptors, clean APIs |
| **Storage** | Hive CE + SharedPrefs | Local caching (`hive_ce`, the maintained fork of the abandoned `hive` package) |
| **DI** | GetIt + Injectable | Each package (`core`/`domain`/`data`/app) generates its own DI config; see [CLAUDE.md](./CLAUDE.md#4-dependency-injection-setup) for how they're composed |
| **Patterns** | `@freezed` states, `Result<T>` (a `(T?, AppFailure?)` record — **not** `Either`/dartz) | Type-safe error handling |

## Quick Start

### 1. Clone & Install

```bash
git clone <repo>
cd flutter_boilerplate
fvm flutter pub get              # Uses pinned Flutter 3.41.8
fvm flutter pub run build_runner build
```

### 2. Add a Feature

```bash
# Create domain layer (business logic)
mkdir -p domain/lib/your_feature/{entities,repositories,usecases}

# Create data layer (API/storage)
mkdir -p data/lib/your_feature/{datasources,models,repositories}

# Create presentation layer (UI)
mkdir -p lib/feature_your_feature/{cubit,pages,widgets}

# Register in DI
fvm flutter pub run build_runner build

# Test
fvm flutter test
fvm flutter run
```

See [CLAUDE.md](./CLAUDE.md) for full patterns (entity → repository → use case → cubit → page).

### 3. Run Tests & Checks

```bash
fvm dart format .
fvm flutter analyze
fvm flutter test
```

## Architecture at a Glance

```
lib/
├── main.dart                     # App entry
├── feature_home/                 # Feature package
│   ├── cubit/                   # State management
│   ├── pages/                   # Full screens
│   └── widgets/                 # Reusable UI
├── routes/                      # Navigation
└── src/injection/               # DI setup

domain/lib/feature_X/            # Business logic (no Flutter)
├── entities/                    # Data models
├── repositories/                # Abstract contracts
└── usecases/                    # Single operations

data/lib/feature_X/              # Data access
├── datasources/                 # HTTP/cache
├── models/                      # JSON mappers
└── repositories/                # Implementations

core/lib/
├── utils/network/               # Dio setup
├── utils/storage/               # Hive/SharedPrefs
├── utils/failure/               # Error types
└── utils/injection/             # DI config
```

## Common Patterns

These are the actual patterns from `home_repository_impl.dart` and
`home_cubit.dart` — not `Either`/dartz, which this project doesn't depend on.

### Error Handling (Type-Safe)

```dart
// Use case/repository returns Result<T> = (T?, AppFailure?) — a record, no exceptions
Future<Result<HomeEntity>> getHomeData() async {
  try {
    final data = await remoteDatasource.getHomeData();
    return (data.toEntity(), null);
  } on DioException catch (e) {
    return (null, NetworkFailure(message: e.message ?? 'Network error'));
  }
}

// Cubit consumes it
final (data, error) = await _getHomeDataUseCase();
if (data != null) {
  emit(HomeLoaded(home: data, lastRefresh: DateTime.now()));
} else if (error != null) {
  emit(HomeError(message: error.message));
}
```

### State Management (Cubit — the real feature has no event classes)

```dart
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required GetHomeDataUseCase getHomeDataUseCase})
    : _getHomeDataUseCase = getHomeDataUseCase,
      super(const HomeInitial());

  final GetHomeDataUseCase _getHomeDataUseCase;

  Future<void> fetchHomeData() async {
    emit(const HomeLoading());
    final (data, error) = await _getHomeDataUseCase();
    if (data != null) {
      emit(HomeLoaded(home: data, lastRefresh: DateTime.now()));
    } else if (error != null) {
      emit(HomeError(message: error.message, canRetry: true));
    }
  }
}
```

### Dependency Injection

Each package (`core`, `domain`, `data`, and the app's own `lib/`) generates
its **own** DI config from its own `@InjectableInit()` entry point; they're
composed together in `lib/src/injection/di.dart`. See
[CLAUDE.md](./CLAUDE.md#4-dependency-injection-setup) for why that matters
and how to rebuild after adding a new `@injectable` class.

```dart
@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository { ... }  // data/lib/

@injectable
class GetHomeDataUseCase { ... }                            // domain/lib/

// Use anywhere once its package has been rebuilt with build_runner
final useCase = getIt<GetHomeDataUseCase>();
```

## Status

Verified as of this writing — re-run these yourself rather than trusting
a static badge:
```bash
fvm flutter analyze     # No issues found
fvm flutter test        # 33/33 passing
fvm dart format .       # Already clean
```

**33 tests**, all in `domain`/`data`/`core` — none in `lib/` (presentation):
- Domain: use cases (6), entities (12)
- Data: models (12)
- Core: error boundary (2 — build-time error → fallback screen, and
  no-error passthrough)
- `test/widget_test.dart`: 1 placeholder (`expect(true, true)`), not a
  real assertion

### What's actually wired up
- ✅ Clean Architecture layers (domain/data/presentation), one real
  feature (Home) built out end-to-end
- ✅ Cubit state management (`HomeCubit`), DI resolves it correctly
  (fixed — see [Known Limitations](#known-limitations) for the bug this
  used to have)
- ✅ Dio networking with interceptors, `Result<T>`-based error mapping
- ✅ go_router navigation with a custom error page and route observer
- ✅ Hive CE + SharedPreferences local storage
- ✅ App flavors (dev/staging/prod)
- ✅ Error boundary that survives build-time errors without crashing
  itself (fixed — previously it crashed on its own error path; see below)

### Known Limitations
- **No CI.** Nothing enforces `analyze`/`test`/`format` on a PR; see
  [Advanced Patterns → CI/CD](#cicd-pipeline-github-actions) for a
  starting workflow.
- **Circular package dependency.** `core` path-depends on `data` and
  `domain`, which path-depend back on `core`. Works today by luck (no
  actual import cycle), but is fragile — see `CLAUDE.md`'s "Avoid These
  Patterns" section.
- **`go_router`'s `isLoggedIn`/`redirectLocation` params are accepted but
  unused** — `AppRouter.getRouter()` takes them and does nothing with
  them. There's no actual auth-guard redirect logic despite what earlier
  versions of this README claimed.
- **Single feature.** The "add features without touching existing code"
  architecture claim is unverified beyond n=1 — Home is the only feature
  that exists.
- **Test coverage stops at domain/data.** No cubit, repository, or widget
  tests. `bloc_test` isn't a dependency (it conflicted with `bloc` 7.x;
  that's no longer true now that `bloc` is 9.x, so adding it is
  unblocked, just not done).
- Two real runtime bugs were found and fixed while auditing this
  template: `HomeCubit`/`HomeRepositoryImpl`/the use cases were never
  registered with GetIt (the app crashed opening its one screen), and
  `ErrorBoundary` crashed on its own error-handling path. Both are fixed
  and covered by tests now, but it's a sign this hadn't been exercised
  end-to-end before.

## Advanced Patterns

### API + Local Cache Strategy (already implemented, not a "coming soon")
Real code from `data/lib/feature_home/repositories/home_repository_impl.dart`
— try the network, fall back to the Hive cache on a `DioException`:
```dart
Future<Result<HomeEntity>> getHomeData() async {
  try {
    final response = await _remoteDatasource.getHomeData();
    final homeModel = HomeModel(/* ...map response fields... */);
    await _cacheBox.put(_cacheKey, jsonEncode(homeModel.toJson()));
    return (homeModel.toEntity(), null);
  } on DioException catch (e) {
    final cachedJson = _cacheBox.get(_cacheKey);
    if (cachedJson != null) {
      final cached = HomeModel.fromJson(jsonDecode(cachedJson) as Map<String, dynamic>);
      return (cached.toEntity(), null);
    }
    return (null, NetworkFailure(message: e.message ?? 'Network error'));
  }
}
```

### App Flavors (Environments) — Already Implemented ✅

Three entry points preconfigured: dev, staging, prod.

```bash
# Dev environment (hot reload, verbose logging, test API)
fvm flutter run -t lib/main_dev.dart

# Staging (integration tests, staging API, analytics)
fvm flutter run -t lib/main_staging.dart

# Production (release mode, prod API, full analytics)
fvm flutter run -t lib/main_prod.dart
```

Configuration stored in `core/lib/utils/flavor/flavor_config.dart`:
- Each flavor has custom app name, baseUrl, feature flags
- Configured automatically via entry point selection
- No `--dart-define` needed — type-safe enum-based setup

### State Persistence (Optional)

Use `hydrated_bloc` for BLoC state auto-save:
```bash
fvm flutter pub add hydrated_bloc
```

```dart
// hydrated_bloc has a HydratedCubit variant too, matching this project's
// Cubit-based style — not shown as installed/tested here, just a pointer.
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  @override
  HomeState? fromJson(Map<String, dynamic> json) => HomeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomeState state) => state.toJson();
}
```

### CI/CD Pipeline (GitHub Actions)

Create `.github/workflows/test.yml`:
```yaml
name: Test & Build

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.41.8'
      - run: fvm flutter pub get
      - run: fvm dart format --output=none --set-exit-if-changed .
      - run: fvm flutter analyze
      - run: fvm flutter test
      - run: fvm flutter build apk --release

  upload-coverage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: fvm flutter test --coverage
      - uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
```

### APK/App Signing

Keystore setup for releases:
```bash
keytool -genkey -v -keystore my-key.jks -keyalg RSA -keysize 2048 \
  -validity 10000 -alias my-key-alias
```

Store securely (not in repo). Configure in `android/local.properties`:
```properties
storeFile=../../my-key.jks
storePassword=your_password
keyAlias=my-key-alias
keyPassword=your_password
```

Then build:
```bash
fvm flutter build appbundle --release  # Google Play
fvm flutter build apk --release        # Standalone APK
```

## Getting Started

**Use right now:**
- Clone & run `fvm flutter pub get`
- `analyze`/`test`/`format` all pass as of this writing (re-verify yourself)
- App flavors preconfigured: `fvm flutter run -t lib/main_dev.dart` (dev/staging/prod)

**Add your first feature:**
- Read [CLAUDE.md](./CLAUDE.md) for the real patterns (entity → repository
  → use case → Cubit → page), including the DI gotcha in
  ["Dependency Injection Setup"](./CLAUDE.md#4-dependency-injection-setup)
- Use `create-feature` skill to scaffold feature structure (if available)
- Run tests after each feature: `fvm flutter test`
- This will be the first feature *besides* Home — the "add features
  without touching existing code" claim hasn't been exercised yet

**Before shipping:**
- Add cubit/repository/widget tests — currently only domain/data have any
- Set up CI/CD with GitHub Actions (see [Advanced Patterns](#advanced-patterns) — there isn't one yet)
- Resolve the `core`↔`data`↔`domain` circular path dependency (see
  [Known Limitations](#known-limitations))
- Wire up or remove `AppRouter`'s unused `isLoggedIn`/`redirectLocation` params
- Enable state persistence with `hydrated_bloc` if needed (optional, untested here)

## Requirements

- **Flutter:** 3.41.8 (pinned in `.fvmrc`, managed by FVM)
- **Dart:** 3.11.5 (bundled with that Flutter version — not independently installed)
- **FVM:** 4.x (tested with 4.1.2; https://fvm.app)
- **IDE:** VS Code or Android Studio recommended

### Install Dependencies

**macOS:**
```bash
brew tap leoafarias/fvm && brew install fvm
# Verify
fvm --version
fvm flutter --version
```

**Linux/Windows:**
See https://fvm.app/docs/getting-started/installation

## Troubleshooting

| Issue | Solution |
|-------|----------|
| `fvm: command not found` | FVM not installed or not in PATH. Run `brew install fvm` |
| `flutter: command not found` | Use `fvm flutter` instead of `flutter` |
| Build runner fails | Run `fvm flutter pub run build_runner clean` then rebuild |
| Port 5037 in use (Android) | Kill adb: `fvm flutter clean` or `lsof -ti:5037 \| xargs kill -9` |
| Tests fail after pubspec change | Run `fvm flutter pub get` and `fvm flutter pub run build_runner build` |

## What Makes This Different?

**vs GetX/Provider:** BLoC/Cubit scales better for complex apps and is
more testable — a matter of preference, not a settled fact.

**vs Copy-Paste Examples:** The Home feature is real, working code you
can read end-to-end across all four packages, not an isolated snippet.
That said, treat it as a worked example to learn from and adapt, not as
battle-tested production code — see [Known Limitations](#known-limitations).

**vs DIY Architecture:** The layer boundaries, DI composition, and error
type hierarchy are already decided and demonstrated once. You still need
to build out testing and CI yourself.

## Contributing

Found a bug? Missing pattern? PRs welcome.

**Before submitting:**
```bash
fvm dart format .
fvm flutter analyze
fvm flutter test
```

## Resources

- [Clean Architecture Guide](https://resocoder.com/clean-architecture-tdd)
- [BLoC Pattern](https://bloclibrary.dev)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [go_router Docs](https://pub.dev/packages/go_router)
- [FVM](https://fvm.app)
- [Retrofit & Dio](https://pub.dev/packages/retrofit)
