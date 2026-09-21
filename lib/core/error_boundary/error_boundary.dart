import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/error_boundary/error_screen.dart';

/// Widget that catches and displays errors gracefully
class ErrorBoundary extends StatefulWidget {
  /// Creates an error boundary
  const ErrorBoundary({required this.child, this.onError, super.key});

  /// Child widget to wrap
  final Widget child;

  /// Callback when error occurs
  final void Function(Object error, StackTrace stack)? onError;

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;
  FlutterExceptionHandler? _previousOnError;

  void _setError(Object error, StackTrace? stackTrace) {
    widget.onError?.call(error, stackTrace ?? StackTrace.current);

    // FlutterError.onError can fire synchronously while a descendant is
    // still mid-build (e.g. a build() method throwing). Calling setState on
    // this ancestor at that point crashes with "setState() ... called
    // during build", so defer it until the current frame has finished.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _stackTrace = stackTrace;
      });
    });
  }

  void _reset() {
    setState(() {
      _error = null;
      _stackTrace = null;
    });
  }

  @override
  void initState() {
    super.initState();
    // Chain to whatever handler was already installed (the test framework's
    // own handler, a crash-reporting SDK, etc.) instead of replacing it.
    _previousOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      _previousOnError?.call(details);
      _setError(details.exception, details.stack);
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      // ErrorBoundary is typically placed above MaterialApp (so it can catch
      // errors from the app's own setup, e.g. router configuration), so once
      // it swaps out `widget.child`, none of MaterialApp's Directionality/
      // Material/Navigator ancestors exist anymore. ErrorScreen uses
      // Scaffold/AppBar/Theme.of, so give it its own self-contained
      // MaterialApp rather than assuming those ancestors are still there.
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ErrorScreen(
          error: _error.toString(),
          stackTrace: _stackTrace?.toString(),
          onRetry: _reset,
        ),
      );
    }

    return widget.child;
  }

  @override
  void dispose() {
    FlutterError.onError = _previousOnError;
    super.dispose();
  }
}
