import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Generic result type for representing success or failure outcomes
///
/// Positional record: (data, error)
/// - First element: data of type T (null on failure)
/// - Second element: error of type AppFailure (null on success)
///
/// Usage:
/// ```
/// final (data, error) = await repository.fetchData();
/// if (data != null) { /* use data */ }
/// if (error != null) { /* handle error */ }
/// ```
typedef Result<T> = (T?, AppFailure?);

/// Helper class for creating Result instances
class ResultHelper {
  /// Creates a success result with the given data
  static Result<T> success<T>(T data) => (data, null);

  /// Creates a failure result with the given error
  static Result<T> failure<T>(AppFailure error) => (null, error);
}

/// Extension to make Result available with static methods
extension ResultX<T> on Result<T> {
  /// Creates a success result with the given data
  static Result<U> success<U>(U data) => (data, null);

  /// Creates a failure result with the given error
  static Result<U> failure<U>(AppFailure error) => (null, error);
}
