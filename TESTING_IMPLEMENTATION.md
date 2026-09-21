# Testing Status

This file used to claim "4/4 layers, complete test suite" while only
2 of 4 layers actually had tests, and it described three test files
(`home_repository_impl_test.dart`, `home_cubit_test.dart`,
`home_page_test.dart`) that were never created. Corrected below to match
what's actually in `test/` — re-run `fvm flutter test` yourself rather
than trusting this file as it ages.

## What exists (33 tests, all passing)

**Domain** (`test/features/home/domain/`)
- `entities/home_entity_test.dart` (12) — equality, `copyWith`,
  `fromJson`/`toJson`, `hashCode`, `toString`, for `HomeEntity` and
  `HomeItemEntity`
- `usecases/get_home_data_usecase_test.dart` (3) and
  `usecases/get_home_detail_usecase_test.dart` (3) — mock `HomeRepository`
  with `mockito`/`@GenerateMocks`, verify success/failure/parameter-passing

**Data** (`test/features/home/data/models/home_model_test.dart`, 12 tests)
- `fromJson`/`toJson` and `toEntity()` mapping for `HomeItemModel`,
  `HomeModel`, `HomeDetailModel`; freezed equality

**Core** (`test/core/error_boundary/error_boundary_test.dart`, 2 tests)
- A descendant throwing during `build()` is caught and shown as a
  self-contained fallback screen, without the boundary crashing on its
  own error-handling path (it used to — see `ERROR_BOUNDARY.md`)
- No-error passthrough renders `child` normally

**`test/widget_test.dart`** — a single `expect(true, true)` placeholder,
not a real assertion. Not counted as meaningful coverage.

## What doesn't exist yet

- No `HomeRepositoryImpl` test (cache hit/miss, network-failure fallback,
  `clearCache`, `watchHomeData` — all real logic in
  `data/lib/feature_home/repositories/home_repository_impl.dart`, untested)
- No `HomeCubit` test
- No `HomePage`/widget-rendering test beyond the placeholder above
- `bloc_test` is not a dependency. It was dropped early on "due to
  conflict with bloc 7.2.1" — `bloc` is on 9.x now, so that's no longer a
  blocker if someone wants to add it

## Dead code worth knowing about

`test/utils/test_utils.dart` defines `pumpApp()`, `MockLocalStorage`,
`MockApiClient`, `MockLogger`, and `TestData` fixtures (`tHomeEntity`,
`tHomeJson()`, etc.) — **none of it is referenced by any current test**.
It looks like scaffolding left over from an attempt at the
cubit/repository/widget tests listed above. Either use it when writing
those tests, or remove it — don't take its presence as evidence those
tests exist.

## Running tests

```bash
fvm flutter test                                          # all 33
fvm flutter test test/features/home/domain/entities/      # one directory
fvm flutter test --coverage                                # lcov output
fvm flutter test -x                                        # stop on first failure
```

## Mocking convention

Real tests use **`mockito`** with `@GenerateMocks([HomeRepository])` above
`main()`, generating a matching `*_test.mocks.dart` via
`fvm flutter pub run build_runner build`. There is no `mocktail` usage
anywhere in this project — don't mix the two APIs.
