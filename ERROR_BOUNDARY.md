# Error Boundary Implementation

Error handling for the Flutter app using an error boundary, a fallback
screen, and dialog/snackbar helpers.

**Three real bugs in this code were found and fixed** while writing an
actual test for it (`test/core/error_boundary/error_boundary_test.dart`)
— see "Bugs Found & Fixed" below before assuming this was already solid.

## Files Created

### `lib/core/error_boundary/`

**error_boundary.dart** — Widget wrapping the app to catch uncaught errors
- Catches FlutterError exceptions
- Displays ErrorScreen on error
- Provides error callback for logging/analytics
- Resets on retry

**error_screen.dart** — UI for displaying unhandled errors
- Shows error message and stack trace (expandable)
- Retry button to reset error state
- Go Home button for navigation
- Styled with red color scheme for emphasis

**error_handler.dart** — Utility for displaying domain-level errors
- `showErrorDialog()` — modal dialog with error message
- `showErrorSnackbar()` — bottom snackbar for errors
- `getErrorMessage()` — extract user-friendly message from AppFailure

**error_boundary_export.dart** — Barrel export for easy imports

## Usage

### 1. App-Level Error Boundary (Already Done)

In `main.dart`:
```dart
return ErrorBoundary(
  onError: (error, stackTrace) {
    debugPrint('Uncaught error: $error\n$stackTrace');
    // Send to analytics/logging service
  },
  child: ScreenUtilInit(...),
);
```

### 2. Handle Domain Errors in Cubits

In cubit:
```dart
final (data, error) = await usecase();
if (error != null) {
  // Show error UI
  ErrorHandler.showErrorSnackbar(context, error);
  emit(MyError(message: error.message));
}
```

### 3. Handle Errors in Pages

In page:
```dart
BlocListener<MyCubit, MyState>(
  listener: (context, state) {
    if (state is MyError) {
      ErrorHandler.showErrorDialog(context, failure);
    }
  },
  child: ...,
)
```

## Error Types

App uses the `AppFailure` hierarchy from `core/lib/utils/failure/app_failure.dart`
(`abstract class AppFailure implements Exception`):
- `NetworkFailure` — HTTP/connection errors
- `CacheFailure` — Local storage errors
- `ValidationFailure` — Input validation
- `AuthFailure` — Auth/authorization errors
- `UnknownFailure` — Unexpected errors

There is no `ServerFailure` class, despite what an earlier version of this
doc (and `CLAUDE.md`) claimed.

## Flow

1. **Uncaught Error** → ErrorBoundary catches → ErrorScreen displays
2. **Expected Error** → Cubit emits error state → Page shows dialog/snackbar
3. **Retry** → User taps retry → Reset error state → Re-fetch data

## Bugs Found & Fixed

Writing a real widget test (`_ThrowingWidget` that throws during `build()`,
wrapped the same way `main.dart` wraps the real app) surfaced three
compounding bugs, each hidden behind the previous one:

1. **`setState()` called during build.** `FlutterError.onError` can fire
   synchronously while a descendant is still mid-build. Calling
   `setState()` on the ancestor `ErrorBoundary` at that exact moment
   crashed with `setState() ... called during build`. Fixed by deferring
   via `WidgetsBinding.instance.addPostFrameCallback`.
2. **Global handler clobbering.** `ErrorBoundary` unconditionally
   overwrote `FlutterError.onError` in `initState()` and hardcoded
   `FlutterError.dumpErrorToConsole` in `dispose()`, discarding whatever
   handler was already installed — including the Flutter test framework's
   own, which broke every widget test that wrapped anything in
   `ErrorBoundary`. Fixed by saving and chaining to the previous handler.
3. **The fallback screen itself crashed.** `ErrorBoundary` sits above
   `MaterialApp` in `main.dart` (so it can catch errors from the app's own
   setup, e.g. router config). Once it swaps in `ErrorScreen` — which uses
   `Scaffold`/`AppBar`/`Theme.of(context)` — there's no `MaterialApp`
   ancestor left to provide `Directionality`/`Material`/`Navigator`, so it
   crashed with "No Directionality widget found." Fixed by wrapping the
   fallback in its own self-contained `MaterialApp`.

All three are covered by `test/core/error_boundary/error_boundary_test.dart`.

## Testing

```bash
fvm flutter test test/core/error_boundary/error_boundary_test.dart
```

The test wraps a widget that throws during `build()` the same way
`main.dart` composes the real app (`ErrorBoundary` → `ScreenUtilInit` →
`MaterialApp`) — a bare `MaterialApp(home: ErrorBoundary(...))` doesn't
reproduce the tree-position bug above.

## Known gap

`ErrorScreen` shows the stack trace unconditionally — there's no
`kDebugMode`/`kReleaseMode` gating despite that being listed as a "best
practice" below. Decide whether that's intentional before shipping.

## Best Practices

✅ Always emit error state in cubits
✅ Show user-friendly messages via ErrorHandler
✅ Log errors for debugging
✅ Provide retry mechanism
⚠️ Don't show stack traces to users in release builds — **not currently
   enforced**, see "Known gap" above

❌ Don't hide errors silently
❌ Don't show raw exception messages
❌ Don't mix error handling patterns
