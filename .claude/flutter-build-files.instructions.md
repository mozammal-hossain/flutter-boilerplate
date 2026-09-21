---
name: flutter-build-files
description: "Use when: editing build.gradle.kts, pubspec.yaml, or other build configuration files. Enforces FVM usage and Flutter best practices."
applyTo: ["**/pubspec.yaml", "**/build.gradle.kts", "analysis_options.yaml"]
---

# Flutter Build Files

Rules for editing Flutter and Gradle build configuration files.

## pubspec.yaml

### When Editing Dependencies

1. **Always test** after modifying:
   ```bash
   fvm flutter pub get
   fvm flutter analyze
   fvm flutter test
   ```

2. **Use exact versions** for critical dependencies:
   ```yaml
   dependencies:
     critical_package: ^1.2.3  # Won't break with updates
   ```

3. **Comment why** unusual versions are pinned:
   ```yaml
   dependencies:
     old_package: ^0.9.0  # v1.0 has breaking changes on null safety
   ```

### Version Constraints

- `^1.2.3` - Caret: allows patches and minor (1.2.3 - 1.x.x)
- `~1.2.3` - Tilde: allows patches only (1.2.3 - 1.2.x)
- `1.2.3` - Exact version (use sparingly)
- `>=1.2.3 <2.0.0` - Range

### Dev Dependencies

Keep dev dependencies separate and organized:
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  # Testing — this project uses mockito (with @GenerateMocks/build_runner),
  # not mocktail. bloc_test is not a dependency (was dropped for a bloc
  # 7.x conflict that no longer applies now that bloc is on 9.x).
  mockito: ^5.0.0

  # Code generation
  build_runner: ^2.0.0

  # Linting
  very_good_analysis: ^10.2.0
```

## build.gradle.kts (Android)

### Changes Require Testing

```bash
fvm flutter build apk --release
fvm flutter build appbundle --release
```

### Common Modifications

Never change Flutter SDK version here directly:
- ❌ **DO NOT**: Edit `com.android.application { ... }`
- ✅ **DO**: Use `.fvmrc` for version control

## analysis_options.yaml

### When Modifying Linting Rules

1. Document why the rule was changed:
   ```yaml
   linter:
     rules:
       - sort_pub_dependencies  # Enforces consistent ordering
       - prefer_final_fields    # Catches accidental mutations
   ```

2. Test analysis still passes:
   ```bash
   fvm flutter analyze
   ```

3. Run full suite to catch impacts:
   ```bash
   fvm flutter analyze
   fvm dart format .
   fvm flutter test
   ```

## Key Points

- 🔍 **Always use FVM**: `fvm flutter pub get`
- 📝 **Comment changes**: Explain why versions are pinned
- ✅ **Test builds**: Verify before committing
- 🚫 **Never modify Flutter SDK path** in build files
- 📌 **Keep versions synced** across packages where needed

