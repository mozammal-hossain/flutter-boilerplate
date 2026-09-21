---
name: dependency-management
description: "Use when: adding/updating dependencies, managing package versions, resolving dependency conflicts, or updating pubspec.yaml files. Always uses FVM for flutter commands."
---

# Dependency Management Skill

Manage dependencies safely across the Flutter boilerplate monorepo.

## Usage

Ask the agent to:
- "Add the http package"
- "Update to the latest flutter_bloc version"
- "Add equatable dependency"
- "Resolve dependency conflicts"
- "Update all dependencies"

## Project Structure

Dependencies are managed in:
- `pubspec.yaml` - Main app and package versions
- `core/pubspec.yaml` - Core package dependencies
- `data/pubspec.yaml` - Data layer dependencies
- `domain/pubspec.yaml` - Domain layer dependencies

## Common Dependencies

### Core Packages
```yaml
dependencies:
  flutter:
    sdk: flutter
  equatable: ^2.0.0          # Value equality
  get_it: ^9.0.0             # Service locator
  # No dartz — error handling uses a plain (T?, AppFailure?) record
  # (core/lib/utils/network/result.dart), not Either.
```

### State Management
```yaml
dependencies:
  flutter_bloc: ^9.0.0       # BLoC pattern (real feature uses Cubit, no events)
  bloc: ^9.0.0
```

### Networking
```yaml
dependencies:
  dio: ^5.0.0                # HTTP client
  retrofit: ^4.0.0           # REST client
```

### Local Storage
```yaml
dependencies:
  hive_ce: ^2.0.0             # Local database — the maintained fork; the
  hive_ce_flutter: ^2.0.0     # official hive/hive_generator is abandoned
  shared_preferences: ^2.0.0  # and blocks modern build_runner/injectable_generator
```

### Testing
```yaml
dev_dependencies:
  mockito: ^5.0.0             # Mocking — this project uses mockito +
                               # @GenerateMocks, not mocktail/bloc_test
```

## Adding Dependencies

### To Main App
Edit `pubspec.yaml` and add under `dependencies`:
```yaml
dependencies:
  new_package: ^1.0.0
```

Then run:
```bash
fvm flutter pub get
```

### To Package (core/data/domain)
Edit the package's `pubspec.yaml`:
```bash
# Example: Add to data package
cd data
fvm flutter pub add new_package
```

### To Dev Dependencies
```bash
fvm flutter pub add --dev dev_package
```

## Updating Dependencies

### Get Latest Versions
```bash
fvm flutter pub get              # Get specified versions
fvm flutter pub upgrade          # Upgrade to latest compatible
fvm flutter pub outdated         # Show outdated packages
```

### Update Specific Package
```bash
fvm flutter pub upgrade package_name
```

### Update All Packages
```bash
fvm flutter pub upgrade
fvm flutter pub get              # Commit changes
```

## Monorepo Dependency Best Practices

### Local Package Dependencies
When a package depends on another local package:

```yaml
dependencies:
  domain:
    path: ../domain
  core:
    path: ../core
```

### Avoid Circular Dependencies
❌ **Bad:**
- `data` depends on `domain` depends on `data`

✅ **Good:**
- `data` → `domain` (data knows about domain)
- `domain` → nothing (core only)
- `presentation` → `domain` and `data`

## Dependency Conflict Resolution

### Pubspec Lock Issues
```bash
rm pubspec.lock
fvm flutter pub get
```

### Version Conflicts
If packages require conflicting versions:
1. Check which packages need what versions: `fvm flutter pub outdated`
2. Use version constraints that satisfy both
3. Consider updating the problematic package

Example conflict:
```yaml
# Package A wants dio: ^5.0.0
# Package B wants dio: ^4.0.0
# Solution: Use ^4.1.0 or update Package B

dependencies:
  dio: ^4.1.0
```

## Checking Dependencies

### List All Dependencies
```bash
fvm flutter pub deps
```

### Check for Unused Packages
```bash
fvm flutter pub remove <package_name>
fvm flutter test  # Verify it wasn't used
git checkout pubspec.yaml  # Restore if needed
```

### Find Dependency Tree
```bash
fvm flutter pub deps --graph
```

## Platform-Specific Dependencies

### Android/iOS/Web
Use platform tags:
```yaml
dependencies:
  android_intent:
    sdk: flutter
    version: ^2.0.0
```

### Conditional Imports
```dart
import 'package:path_provider/path_provider.dart'
    if (dart.library.html) 'package:path_provider_web/path_provider_web.dart';
```

## Security

- ✅ Regularly update critical packages
- ✅ Check for known vulnerabilities: `fvm flutter pub outdated`
- ❌ Don't use unpopular or unmaintained packages
- ❌ Don't pin versions unless absolutely necessary

## Pre-Commit Checklist

Before committing dependency changes:

```bash
fvm flutter pub get
fvm flutter analyze         # Check for issues
fvm flutter test            # Ensure tests still pass
git status                  # Verify only pubspec.yaml/lock changed
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "pub get failed" | `fvm flutter pub get --offline` or check internet |
| "version conflict" | `fvm flutter pub upgrade` or manually edit versions |
| "strange build errors" | `fvm flutter clean && fvm flutter pub get` |
| "locked version mismatch" | Delete `pubspec.lock` and run `fvm flutter pub get` |

## Resources

- [Pub.dev](https://pub.dev) - Find packages
- [Flutter Packages](https://flutter.dev/docs/development/packages-and-plugins)
- [Effective Dart - Style](https://dart.dev/guides/language/effective-dart/style)
