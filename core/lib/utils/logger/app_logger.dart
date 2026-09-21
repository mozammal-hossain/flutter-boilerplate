import 'dart:convert';
import 'package:logger/logger.dart';

/// Application logger configuration
/// Centralized logging utility for the app
class AppLogger {
  /// Private constructor to prevent instantiation
  AppLogger._();

  /// Logger instance
  static late Logger _logger;

  /// Whether logging is enabled
  static bool _isEnabled = true;

  /// Initializes the logger with custom configuration
  static void init({
    Level level = Level.debug,
    bool enable = true,
    Logger? customLogger,
  }) {
    _isEnabled = enable;
    _logger =
        customLogger ??
        Logger(
          level: level,
          printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 5,
            lineLength: 80,
            printEmojis: false,
          ),
        );
  }

  /// Logs a verbose message
  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.t(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a debug message
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs an info message
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.i(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a warning message
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs an error message
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a wtf (What a Terrible Failure) message
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.f(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs an object
  static void logObject(Object object, {String? name}) {
    if (_isEnabled) {
      _logger.i('${name ?? 'Object'}: $object');
    }
  }

  /// Logs a JSON object (pretty printed)
  static void logJson(Map<String, dynamic> json, {String? name}) {
    if (_isEnabled) {
      const encoder = JsonEncoder.withIndent('  ');
      _logger.i('${name ?? 'JSON'}:\n${encoder.convert(json)}');
    }
  }

  /// Logs an API request
  static void logRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    if (_isEnabled) {
      final buffer = StringBuffer()
        ..writeln('→ $method $url')
        ..writeln('Headers: $headers');
      if (body != null) {
        buffer.writeln('Body: $body');
      }
      _logger.d(buffer.toString());
    }
  }

  /// Logs an API response
  static void logResponse({
    required int statusCode,
    required String url,
    dynamic data,
  }) {
    if (_isEnabled) {
      _logger.d('← $statusCode $url\nResponse: $data');
    }
  }

  /// Disables logging
  static void disable() {
    _isEnabled = false;
  }

  /// Enables logging
  static void enable() {
    _isEnabled = true;
  }

  /// Toggles logging
  static void toggle() {
    _isEnabled = !_isEnabled;
  }
}
