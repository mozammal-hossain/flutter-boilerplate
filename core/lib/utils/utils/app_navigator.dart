import 'package:flutter/material.dart';

/// Global navigation utility
///
/// Provides helper methods for common navigation patterns
/// and access to the current navigation state.
class AppNavigator {
  AppNavigator._();

  /// Global navigator key for accessing navigation state from anywhere
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get current context from navigator key
  static BuildContext? get context => navigatorKey.currentContext;

  /// Push a new route onto the navigator
  static Future<T?>? push<T extends Object?>(Route<T> route) =>
      navigatorKey.currentState?.push<T>(route);

  /// Push a named route onto the navigator
  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      navigatorKey.currentState?.pushNamed<T>(routeName, arguments: arguments);

  /// Push a named route and remove all previous routes
  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    required bool Function(Route<dynamic>) predicate,
    Object? arguments,
  }) => navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
    routeName,
    predicate,
    arguments: arguments,
  );

  /// Push a named route and remove all previous routes until a specific route
  static Future<T?>? pushNamedAndRemoveUntilUntil<T extends Object?>(
    String newRouteName,
    String removeUntilRouteName, {
    Object? arguments,
  }) => navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
    newRouteName,
    ModalRoute.withName(removeUntilRouteName),
    arguments: arguments,
  );

  /// Replace the current route with a new route
  static Future<T?>? pushReplacementNamed<
    T extends Object?,
    TO extends Object?
  >(String routeName, {TO? result, Object? arguments}) =>
      navigatorKey.currentState?.pushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  /// Pop all routes and push a new route
  static Future<T?>? pushNamedAndRemoveAll<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) => pushNamedAndRemoveUntil<T>(
    routeName,
    arguments: arguments,
    predicate: (_) => false,
  );

  /// Pop the top-most route off the navigator
  static void pop<T extends Object?>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop<T>(result);
    }
  }

  /// Check if the navigator can pop
  static bool canPop() => navigatorKey.currentState?.canPop() ?? false;

  /// Pop until a specific route
  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }
}
