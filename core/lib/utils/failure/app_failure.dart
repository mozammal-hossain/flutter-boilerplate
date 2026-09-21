/// Base class for all application failures
/// This sealed class hierarchy represents all possible failures in the app
abstract class AppFailure implements Exception {
  /// Creates a new AppFailure
  const AppFailure({
    required this.code,
    required this.message,
    this.stackTrace,
  });

  /// Unique error code for identification
  final String code;

  /// Human-readable error message
  final String message;

  /// Optional stack trace for debugging
  final StackTrace? stackTrace;

  /// Convert to JSON map
  Map<String, dynamic> toJson();

  @override
  String toString() => 'AppFailure(code: $code, message: $message)';
}

/// Failure that occurs during network operations
class NetworkFailure extends AppFailure {
  /// Creates a NetworkFailure
  const NetworkFailure({
    required super.message,
    this.statusCode,
    this.responseBody,
    super.stackTrace,
  }) : super(code: 'NETWORK_FAILURE');

  /// HTTP status code if available
  final int? statusCode;

  /// Response body from the server
  final String? responseBody;

  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'statusCode': statusCode,
    'responseBody': responseBody,
  };
}

/// Failure that occurs during local storage operations
class CacheFailure extends AppFailure {
  /// Creates a CacheFailure
  const CacheFailure({required super.message, this.key, super.stackTrace})
    : super(code: 'CACHE_FAILURE');

  /// Key that caused the failure
  final String? key;

  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'key': key,
  };
}

/// Failure for validation errors
class ValidationFailure extends AppFailure {
  /// Creates a ValidationFailure
  const ValidationFailure({
    required super.message,
    this.field,
    List<String>? errors,
    super.stackTrace,
  }) : errors = errors ?? const [],
       super(code: 'VALIDATION_FAILURE');

  /// Field that failed validation
  final String? field;

  /// List of validation error messages
  final List<String> errors;

  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'field': field,
    'errors': errors,
  };
}

/// Failure for authentication/authorization errors
class AuthFailure extends AppFailure {
  /// Creates an AuthFailure
  const AuthFailure({
    required super.message,
    this.canRefresh = false,
    super.stackTrace,
  }) : super(code: 'AUTH_FAILURE');

  /// Whether token refresh is possible
  final bool canRefresh;

  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'canRefresh': canRefresh,
  };
}

/// Unknown/unexpected failure
class UnknownFailure extends AppFailure {
  /// Creates an UnknownFailure
  const UnknownFailure({
    required super.message,
    this.exception,
    super.stackTrace,
  }) : super(code: 'UNKNOWN_FAILURE');

  /// Original exception that caused this failure
  final dynamic exception;

  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'exception': exception?.toString(),
  };
}
