# `.claude` Project Rules & Configuration

This directory contains Copilot agent configuration, instructions, and skills for the Flutter boilerplate project. These rules ensure consistent development practices across the team.

## 📋 Configuration Files

### Main Instructions
- **[copilot-instructions.md](copilot-instructions.md)** - Project-wide rules that apply everywhere
  - FVM (Flutter Version Management) requirement
  - Architecture patterns (clean architecture)
  - Code standards (null safety, formatting)
  - Testing requirements
  - Git workflow
  - Build & deployment commands
  - Best practices and troubleshooting

### File-Level Instructions
- **[flutter-build-files.instructions.md](flutter-build-files.instructions.md)** - Applied to `pubspec.yaml`, `build.gradle.kts`, and `analysis_options.yaml`
  - Dependency management guidelines
  - Build configuration rules
  - Testing requirements for build changes

- **[flutter-feature-development.instructions.md](flutter-feature-development.instructions.md)** - Applied to `lib/features/**`
  - Feature structure and layers (presentation/domain/data)
  - BLoC pattern implementation
  - Code examples for each layer
  - Dependency injection setup
  - Testing patterns

- **[flutter-testing.instructions.md](flutter-testing.instructions.md)** - Applied to `test/**` and `**/test/**`
  - Unit test examples
  - BLoC testing with bloc_test
  - Widget testing patterns
  - Mocking with Mocktail
  - Test data fixtures
  - Coverage goals

## 🎯 Skills (Specialized Workflows)

Skills are on-demand workflows triggered by specific requests. Ask the Copilot agent for:

### Create Feature Skill
```
/create-feature
```
- **Location**: [skills/create-feature/SKILL.md](skills/create-feature/SKILL.md)
- **Usage**: "Create a feature for notifications"
- **What it does**: 
  - Scaffolds complete feature structure (presentation/domain/data)
  - Generates BLoC boilerplate
  - Creates entities, use cases, repositories
  - Sets up dependency injection
  - Generates unit tests

### Code Quality Skill
```
/code-quality
```
- **Location**: [skills/code-quality/SKILL.md](skills/code-quality/SKILL.md)
- **Usage**: "Run all tests", "Format and analyze the code"
- **What it does**:
  - Formats code using `fvm dart format`
  - Runs static analysis with `fvm flutter analyze`
  - Executes all tests
  - Generates coverage reports
  - Pre-commit checks

### Dependency Management Skill
```
/dependency-management
```
- **Location**: [skills/dependency-management/SKILL.md](skills/dependency-management/SKILL.md)
- **Usage**: "Add the http package", "Update to latest flutter_bloc"
- **What it does**:
  - Adds/updates dependencies safely
  - Resolves version conflicts
  - Manages monorepo dependencies
  - Explains dependency constraints
  - Tests after changes

## 🚀 Quick Reference

### Essential Commands (Always use FVM)
```bash
# Format code
fvm dart format .

# Analyze for issues
fvm flutter analyze

# Get dependencies
fvm flutter pub get

# Run tests
fvm flutter test

# Run app
fvm flutter run

# Build for release
fvm flutter build apk --release
fvm flutter build ios --release
fvm flutter build web --release
```

### Feature Development
1. Ask: "Create a feature for [feature-name]"
2. Implement business logic in domain layer
3. Implement data access in data layer
4. Implement UI with BLoC in presentation layer
5. Run: `fvm flutter test`
6. Run: `fvm flutter analyze`

### Before Committing
```bash
fvm dart format .
fvm flutter analyze
fvm flutter test
git add .
git commit -m "feat: description"
```

## 📚 Project Structure

```
flutter_boilerplate/
├── .claude/                           # ← You are here
│   ├── copilot-instructions.md        # Main rules (always loaded)
│   ├── flutter-build-files.instructions.md    # Build file rules
│   ├── flutter-feature-development.instructions.md  # Feature rules
│   ├── flutter-testing.instructions.md        # Testing rules
│   └── skills/
│       ├── create-feature/SKILL.md
│       ├── code-quality/SKILL.md
│       └── dependency-management/SKILL.md
│
├── lib/                               # Main app
│   ├── features/                      # Feature modules
│   ├── routes/                        # Navigation
│   └── src/                           # Infrastructure
│
├── core/, data/, domain/              # Packages
├── test/, <pkg>/test/                 # Tests
└── pubspec.yaml                       # Dependencies
```

## 🔧 How Copilot Uses These Rules

1. **When you ask a question**, Copilot checks which rules apply
2. **Instructions load automatically** for relevant files/directories
3. **Skills appear as suggestions** or can be invoked with `/skill-name`
4. **FVM requirement** is enforced in all Flutter commands
5. **Code patterns** are followed consistently

## 💡 Key Principles

- **Always use FVM**: Never run `flutter` directly
- **Clean Architecture**: Separate presentation/domain/data layers
- **BLoC Pattern**: Use for state management
- **Test Coverage**: Minimum 70% for new code
- **Code Quality**: Run format, analyze, and tests before committing
- **Monorepo**: Keep core, data, and domain as independent packages
- **Null Safety**: No deprecated patterns
- **Documentation**: Comment complex logic with doc comments

## 🔍 Troubleshooting

### "fvm: command not found"
```bash
brew install fvm
fvm install
fvm use
```

### Rules not appearing?
- Check file location and YAML frontmatter syntax
- Verify `applyTo` patterns match your files
- Restart Copilot (reload VS Code)

### Building with tests failing?
```bash
fvm flutter test -x              # Stop on first failure
fvm flutter test --verbose       # See detailed output
```

### Need help?
- Ask Copilot: "How do I [task]?"
- Check relevant instruction file
- Refer to comments in existing code

## 📖 Resources

- [Flutter Documentation](https://flutter.dev)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [BLoC Pattern](https://bloclibrary.dev)
- [FVM Documentation](https://fvm.app)
- [Clean Architecture](https://resocoder.com/clean-architecture-tdd)

---

**Last Updated**: April 25, 2026
