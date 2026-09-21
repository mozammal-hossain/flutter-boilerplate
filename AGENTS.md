# AGENTS.md

Instructions for AI coding agents (Codex, Cursor, Copilot, Claude Code,
etc.) working in this repository. Claude Code also reads `CLAUDE.md`,
which has the full detail (code samples, DI wiring, testing patterns) —
this file is the tool-agnostic summary.

## Project

**flutter_boilerplate** — a Flutter Clean Architecture boilerplate/starter
kit. Monorepo of path-dependency packages: `core/`, `domain/`, `data/`,
and the app itself (`lib/`). One real feature (Home) is built out
end-to-end across all four as a worked example. See `README.md`'s
"Known Limitations" section before assuming any pattern is more broadly
proven than that.

## Setup & commands

Always use **FVM** — never call `flutter`/`dart` directly; this repo pins
Flutter 3.41.8 via `.fvmrc`.

```bash
fvm flutter pub get                                    # install deps (run in root; syncs path packages)
fvm dart format .                                       # format
fvm flutter analyze                                      # static analysis
fvm flutter test                                         # run tests
fvm flutter pub run build_runner build --delete-conflicting-outputs   # codegen (freezed/json_serializable/injectable/retrofit)
```

Run the full check sequence (`format` → `analyze` → `test`) before
considering any change done.

## Architecture rules

- Dependency direction is a strict DAG: `domain → core`, `data → domain,
  core`, `core → (nothing)`. Never add a path dependency from `core` to
  `data`/`domain` — this happened once already and was a real bug (see
  CLAUDE.md's "Avoid These Patterns").
- Domain/presentation layers return `Result<T>` (`typedef Result<T> =
  (T?, AppFailure?)`, a positional record — **not** `Either`/dartz, which
  this project does not depend on). Never `try/catch` in those layers;
  catch exceptions only in the data layer and map them to `AppFailure`
  subtypes (`core/lib/utils/failure/app_failure.dart`).
- State management is **Cubit**, not `Bloc<Event, State>` — call a
  method, `emit()` states directly, no event classes. States are
  `@freezed` unions consumed via `.when()`.
- DI: annotate classes directly (`@injectable`, `@LazySingleton(as:
  Interface)`). Each package (`core`, `domain`, `data`, app) generates
  its **own** DI config from its own `@InjectableInit()` entry point —
  a new annotation is invisible to GetIt until you rebuild
  `build_runner` **in that specific package**, not just the root. This
  bit the project once already (see CLAUDE.md, section 4).

## Testing

Mocking uses `mockito` + `@GenerateMocks` (code-generated
`.mocks.dart`) — not `mocktail`. `bloc_test` is not a dependency; drive
Cubits directly and assert on `.stream`/`.state`. See CLAUDE.md's
"Testing" section for real examples from this codebase.

## Before finishing any task

```bash
fvm dart format .
fvm flutter analyze
fvm flutter test
```

Fix any failures — do not leave `analyze`/`test` red or hand off with
`--no-verify`-style shortcuts.
