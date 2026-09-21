---
name: code-quality
description: "Use when: running tests, checking code quality, formatting code, analyzing for issues, or validating before commit. Ensures all checks pass using FVM."
---

# Code Quality Skill

Maintain code quality standards across the Flutter boilerplate project.

## Usage

Ask the agent to:
- "Run all tests"
- "Format and analyze the code"
- "Check code quality before commit"
- "Run coverage report"
- "Fix all linting issues"

## Quality Checks

### 1. Format Code
Ensures consistent code style using Dart formatter:
```bash
fvm dart format .
```

### 2. Analyze
Runs static analysis using rules from `analysis_options.yaml`:
```bash
fvm flutter analyze
```

**Common issues this catches:**
- Missing return types
- Unused imports/variables
- Null safety violations
- Dead code
- Missing doc comments

### 3. Run Tests
Executes all unit and widget tests:
```bash
fvm flutter test
```

**Test locations:**
- `test/` - Widget and integration tests
- `core/test/` - Core package tests
- `data/test/` - Data layer tests
- `domain/test/` - Domain layer tests

### 4. Coverage Report
Generate test coverage (requires `coverage` package):
```bash
fvm flutter test --coverage
```

Coverage files generated in `coverage/`

## Pre-Commit Checklist

Before committing, run in order:

1. **Format**: `fvm dart format .`
2. **Analyze**: `fvm flutter analyze` (must have zero issues)
3. **Test**: `fvm flutter test` (all tests must pass)
4. **Commit**: `git commit -m "feat: description"`

## CI/CD Integration

In GitHub Actions, these checks run automatically:
- Code format verification
- Static analysis
- All unit tests (with coverage)
- Platform builds (Android, iOS, Web)

## Common Issues & Fixes

| Issue | Fix |
|-------|-----|
| Analysis errors | `fvm flutter pub get && fvm flutter analyze` |
| Test failures | Run `fvm flutter test` to see detailed output |
| Format conflicts | `fvm dart format .` to auto-fix |
| Coverage too low | Write tests in `test/` or package `test/` dirs |
| Outdated dependencies | `fvm flutter pub upgrade` |

## Coverage Goals

- **New features**: Minimum 70% coverage
- **Bug fixes**: Test the fixed behavior
- **Refactoring**: Maintain existing coverage

## Useful Commands

| Command | Purpose |
|---------|---------|
| `fvm flutter test --verbose` | Detailed test output |
| `fvm flutter test --coverage` | Generate coverage report |
| `fvm flutter analyze --fatal-infos` | Treat info as error |
| `fvm flutter pub cache repair` | Fix dependency cache |
| `fvm flutter clean` | Clean build artifacts |

## Notes

- Always use **FVM** prefix for flutter commands
- Fix analysis errors immediately
- Keep tests focused and isolated
- Use meaningful test names
- Maintain high code quality standards
