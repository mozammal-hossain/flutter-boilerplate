import 'dart:async';
import 'package:flutter/material.dart';

/// Extension methods for [BuildContext] class
extension ContextExtensions on BuildContext {
  /// Returns the current theme
  ThemeData get theme => Theme.of(this);

  /// Returns the current color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Checks if the current brightness is dark
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  /// Returns the screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the status bar height
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Returns the bottom padding (home indicator or nav bar)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Hides the keyboard
  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// Checks if the keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Returns the device pixel ratio
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Returns a localized string from the app's strings
  String localString(String key) {
    // This is a placeholder - actual localization implementation will vary
    return key;
  }

  /// Navigate to a new route
  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate and replace current route
  Future<T?> navigateToReplacement<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// Navigate and clear all previous routes
  Future<T?> navigateToAndClearAll<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pop the current route
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Can pop the current route
  bool get canPop => Navigator.of(this).canPop();

  /// Show a snackbar
  ScaffoldMessengerState get snackbar => ScaffoldMessenger.of(this);

  /// Show a simple snackbar
  void showSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), duration: duration, action: action),
    );
  }

  /// Show an error snackbar
  void showErrorSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: duration,
      ),
    );
  }

  /// Show a success snackbar
  void showSuccessSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.primary,
        duration: duration,
      ),
    );
  }

  /// Display a custom dialog
  Future<T?> showAppDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  /// Display a simple alert dialog
  Future<bool?> showAlertDialog({
    required String title,
    required String content,
    String confirmText = 'OK',
    String? cancelText,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Get a dependency from the nearest inherited widget
  T? dependOnInheritedWidget<T extends InheritedWidget>({
    required String aspect,
    T Function()? builder,
  }) {
    return getElementForInheritedWidgetOfExactType<T>()?.widget as T?;
  }

  /// Reads a dependency from the nearest inherited widget
  T readInheritedWidget<T extends InheritedWidget>({required String aspect}) {
    return getElementForInheritedWidgetOfExactType<T>()!.widget as T;
  }
}
