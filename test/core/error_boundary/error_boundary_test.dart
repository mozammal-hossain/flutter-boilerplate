import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/error_boundary/error_boundary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// Throws during build to simulate a real widget-tree error.
class _ThrowingWidget extends StatelessWidget {
  const _ThrowingWidget();

  @override
  Widget build(BuildContext context) {
    throw Exception('boom');
  }
}

/// Wraps [child] the same way `main.dart` composes the real app:
/// `ErrorBoundary` wrapping `ScreenUtilInit` wrapping `MaterialApp`. This
/// matters because `ErrorScreen` uses screenutil's `.w`/`.h` sizing, so it
/// only works once `ScreenUtilInit` has initialized at least once — exactly
/// as happens in the real app before any descendant can throw.
Widget _appLike(Widget child) {
  return ErrorBoundary(
    child: ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(home: child),
    ),
  );
}

void main() {
  testWidgets(
    'ErrorBoundary shows the error screen when a descendant throws during '
    'build, without crashing on setState-during-build',
    (WidgetTester tester) async {
      await tester.pumpWidget(_appLike(const _ThrowingWidget()));

      // FlutterError.onError fires synchronously mid-build; ErrorBoundary
      // must defer its setState until after this frame instead of crashing.
      await tester.pump();

      // ErrorBoundary chains to the previously-installed handler (here, the
      // test framework's own), so the exception is still recorded there;
      // consume it so the test doesn't fail at teardown.
      expect(tester.takeException(), isException);
      expect(find.textContaining('boom'), findsWidgets);
    },
  );

  testWidgets('ErrorBoundary renders child when there is no error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_appLike(const Text('all good')));

    expect(find.text('all good'), findsOneWidget);
  });
}
