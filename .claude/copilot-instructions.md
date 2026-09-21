---
name: flutter-boilerplate-rules
description: "Project-wide rules for Flutter boilerplate development. Use when working on any part of this monorepo project — enforces FVM usage, architecture patterns, and code quality standards."
---

# Flutter Boilerplate Project Rules

## 🔧 Flutter Version Management (FVM)

**CRITICAL: Always use FVM when running Flutter commands. Never use `flutter` directly.**

### Command Convention
- ✅ **DO**: `fvm flutter pub get`, `fvm flutter run`, `fvm flutter build`, `fvm flutter analyze`
- ❌ **NEVER**: `flutter pub get`, `flutter run`, `flutter build`

### Why FVM?
This project enforces a specific Flutter version via `.fvmrc`. Using FVM ensures:
- Team members use the same Flutter SDK
- CI/CD consistency
- No version mismatch issues

### Setup (if needed)
```bash
brew install fvm
fvm install
fvm use
```

---

## 📦 Project Architecture

This is a **monorepo with clean architecture layers**:

```
flutter_boilerplate/
├── lib/                    # Main app (presentation layer)
│   ├── main.dart
│   ├── features/           # Feature modules
│   │   ├── auth/
│   │   ├── home/
│   │   ├── profile/
│   │   └── settings/
│   ├── routes/             # Navigation
│   ├── src/                # App infrastructure
│   │   ├── bloc_observer.dart
│   │   ├── base/
│   │   ├── constants/
│   │   ├── failure/
│   │   ├── injection/      # Dependency injection
│   │   ├── logger/
│   │   ├── network/
│   │   ├── storage/
│   │   ├── theme/
│   │   └── utils/
│   └── core.dart           # Core exports
│
├── core/                   # Core package (shared utilities)
├── data/                   # Data layer (repositories, data sources)
├── domain/                 # Domain layer (entities, use cases)
│
├── android/, ios/, web/, linux/, windows/  # Platform-specific
└── test/                   # Widget tests
```

### Package Dependencies
Each package is independently versionable and testable:
- **core**: Shared utilities, constants, extensions
- **data**: Repository implementations, remote/local data sources
- **domain**: Entities, use cases, interfaces

---

## ✅ Code Standards

### Dart Style & Conventions
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` via FVM: `fvm dart format .`
- Max line length: 80 characters (enforced by analysis_options.yaml)
- Use meaningful variable/function names

### Analysis & Linting
```bash
fvm flutter analyze           # Run static analysis
fvm flutter pub get           # Fetch dependencies
```

Violations defined in `analysis_options.yaml` must be fixed before committing.

### Null Safety
- This project is **null-safe**
- Use `?` and `!` operators correctly
- Avoid `late` keyword unless absolutely necessary

---

## 🧪 Testing Requirements

### Unit & Widget Tests
- Tests in `test/` and `<package>/test/` directories
- Use `test` package for unit tests, `flutter_test` for widget tests
- Minimum coverage goal: **70%** for new code

### Running Tests
```bash
fvm flutter test                    # All tests
fvm flutter test test/widget_test.dart    # Specific file
fvm flutter test --coverage         # With coverage report
```

### Test Structure
```dart
void main() {
  group('Feature: UserRepository', () {
    test('should fetch user successfully', () async {
      // arrange, act, assert
    });
  });
}
```

---

## 🏗️ Feature Development Workflow

### 1. Create a New Feature
When adding a feature (e.g., `notifications`):

```
lib/features/notifications/
├── presentation/
│   ├── bloc/
│   │   ├── notification_bloc.dart
│   │   ├── notification_event.dart
│   │   └── notification_state.dart
│   ├── pages/
│   └── widgets/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── data/
    ├── datasources/
    ├── models/
    └── repositories/
```

### 2. Dependency Injection
Register services in `lib/src/injection/injection_container.dart`:

```dart
void setupInjection() {
  // Register repositories
  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(
      remoteDatasource: getIt(),
    ),
  );
  
  // Register use cases
  getIt.registerSingleton<GetNotificationsUseCase>(
    GetNotificationsUseCase(getIt()),
  );
  
  // Register BLoCs
  getIt.registerFactory<NotificationBloc>(
    () => NotificationBloc(getIt()),
  );
}
```

### 3. BLoC Pattern
Follow BLoC pattern for state management:
- Immutable events and states
- Use `Equatable` for equality
- Use `async*` generator functions for stream logic

---

## 🔄 Git & Commit Workflow

### Commit Messages
Follow conventional commits:
- `feat: add notification feature`
- `fix: resolve null safety in auth bloc`
- `docs: update README with FVM setup`
- `test: add tests for user repository`
- `refactor: simplify network layer`

### Before Committing
```bash
fvm dart format .
fvm flutter analyze
fvm flutter test
```

All checks must pass before committing.

---

## 🚀 Build & Deployment

### Development Build
```bash
fvm flutter run                      # Debug build
fvm flutter run -d <device-id>      # Specific device
fvm flutter run --release            # Release build
```

### Production Build
```bash
# Android
fvm flutter build apk --release
fvm flutter build appbundle --release

# iOS
fvm flutter build ios --release

# Web
fvm flutter build web --release

# Desktop
fvm flutter build linux --release
fvm flutter build windows --release
```

---

## 📝 Documentation Standards

### Code Comments
- Use doc comments (`///`) for public APIs
- Explain *why*, not *what*
- Keep comments up-to-date

Example:
```dart
/// Fetches paginated list of notifications.
/// 
/// Uses offset-based pagination. Returns empty list if no more data.
/// 
/// Throws [NetworkException] on network failure.
Future<List<Notification>> fetchNotifications(int page) async {
  // Implementation...
}
```

### README Files
- Each package has its own README.md
- Document purpose, dependencies, and usage
- Keep in sync with code changes

---

## 🔐 Best Practices

### Don't
- ❌ Use `BuildContext` across async gaps
- ❌ Initialize heavy objects in `build()` methods
- ❌ Use unchecked casts (e.g., `as String`)
- ❌ Ignore linter warnings
- ❌ Create circular dependencies between packages
- ❌ Use `flutter` command directly (always use FVM)

### Do
- ✅ Use `flutter_bloc` for complex state management
- ✅ Separate business logic from UI
- ✅ Use constants instead of magic strings/numbers
- ✅ Handle all error cases explicitly
- ✅ Write tests for critical paths
- ✅ Use `fvm` for all Flutter commands

---

## 🛠️ Troubleshooting

### Common Issues

**"fvm: command not found"**
```bash
brew install fvm
fvm install
fvm use
```

**"Flutter SDK version mismatch"**
```bash
fvm install                    # Installs version from .fvmrc
fvm use                        # Activates it
```

**"pubspec.lock conflicts"**
```bash
fvm flutter pub get --offline
# or
rm pubspec.lock
fvm flutter pub get
```

**Analyze fails after package update**
```bash
fvm flutter pub get
fvm flutter pub upgrade
fvm flutter analyze
```

---

## 📞 Quick Commands Reference

| Task | Command |
|------|---------|
| Format code | `fvm dart format .` |
| Analyze | `fvm flutter analyze` |
| Get packages | `fvm flutter pub get` |
| Run tests | `fvm flutter test` |
| Run app | `fvm flutter run` |
| Clean build | `fvm flutter clean && fvm flutter pub get` |
| Build APK | `fvm flutter build apk --release` |
| Build iOS | `fvm flutter build ios --release` |

---

## 📚 Resources

- [Flutter Documentation](https://flutter.dev)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [BLoC Pattern](https://bloclibrary.dev)
- [FVM Documentation](https://fvm.app)
- [Clean Architecture](https://resocoder.com/clean-architecture-tdd)
