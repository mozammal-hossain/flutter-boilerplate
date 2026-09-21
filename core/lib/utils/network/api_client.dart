import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:injectable/injectable.dart';

/// HTTP client implementation using Dio
/// Handles all network operations with proper error handling
@LazySingleton()
class ApiClient {
  /// Creates an [ApiClient]
  ApiClient({
    required Dio dio,
    @Named('baseUrl') String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    this.maxRetries = 3,
  }) : baseUrl = baseUrl ?? AppConstants.baseUrl,
       _dio = dio,
       connectTimeout = connectTimeout ?? const Duration(seconds: 30),
       receiveTimeout = receiveTimeout ?? const Duration(seconds: 30) {
    _setupDio();
  }

  /// Dio instance
  final Dio _dio;

  /// Base URL for API endpoints
  final String baseUrl;

  /// Connection timeout duration
  final Duration connectTimeout;

  /// Receive timeout duration
  final Duration receiveTimeout;

  /// Maximum number of retries for failed requests
  final int maxRetries;

  /// Configures Dio with interceptors and options
  void _setupDio() {
    _dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      )
      ..interceptors.add(LoggingInterceptor());
  }

  /// Adds authentication interceptor to the client
  void addAuthInterceptor({
    required Future<String?> Function() getToken,
    Future<String?> Function()? refreshToken,
  }) {
    _dio.interceptors.add(
      AuthInterceptor(getToken: getToken, refreshToken: refreshToken),
    );
  }

  /// Adds a custom interceptor
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// Performs a GET request
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return ResultHelper.success(response.data as T);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Performs a POST request
  Future<Result<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ResultHelper.success(response.data as T);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Performs a PUT request
  Future<Result<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ResultHelper.success(response.data as T);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Performs a PATCH request
  Future<Result<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ResultHelper.success(response.data as T);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Performs a DELETE request
  Future<Result<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ResultHelper.success(response.data as T);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Performs a multipart upload
  Future<Result<T>> upload<T>(
    String path,
    FormData formData, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return ResultHelper.success(response.data as T);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Downloads a file
  Future<Result<String>> download(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
      );
      return ResultHelper.success(savePath);
    } catch (e) {
      if (_isDioError(e)) {
        return ResultHelper.failure(_mapError(e as dynamic));
      }
      rethrow;
    }
  }

  /// Checks if exception is a Dio error
  /// Compatible with both DioError and DioException
  bool _isDioError(dynamic e) {
    final typeName = (e as dynamic).runtimeType.toString();
    final response = (e as dynamic).response;
    final type = (e as dynamic).type;
    return typeName.contains('DioError') ||
        typeName.contains('DioException') ||
        (response != null || type != null);
  }

  /// Maps Dio error to AppFailure
  /// Compatible with Dio 4.x
  AppFailure _mapError(dynamic error) {
    final response = (error as dynamic).response as Response?;
    final errorType = (error as dynamic).type;

    // Handle HTTP response errors
    if (response != null) {
      final statusCode = response.statusCode ?? 0;
      final responseBody = (response.data as dynamic)?.toString();

      switch (statusCode) {
        case 400:
          return NetworkFailure(
            message: 'Bad request',
            statusCode: statusCode,
            responseBody: responseBody,
            stackTrace: (error as dynamic).stackTrace as StackTrace?,
          );
        case 401:
          return NetworkFailure(
            message: 'Unauthorized',
            statusCode: statusCode,
            responseBody: responseBody,
            stackTrace: (error as dynamic).stackTrace as StackTrace?,
          );
        case 403:
          return NetworkFailure(
            message: 'Forbidden',
            statusCode: statusCode,
            responseBody: responseBody,
            stackTrace: (error as dynamic).stackTrace as StackTrace?,
          );
        case 404:
          return NetworkFailure(
            message: 'Not found',
            statusCode: statusCode,
            responseBody: responseBody,
            stackTrace: (error as dynamic).stackTrace as StackTrace?,
          );
        case 500:
        case 502:
        case 503:
        case 504:
          return NetworkFailure(
            message: 'Server error',
            statusCode: statusCode,
            responseBody: responseBody,
            stackTrace: (error as dynamic).stackTrace as StackTrace?,
          );
        default:
          return NetworkFailure(
            message: 'HTTP Error: $statusCode',
            statusCode: statusCode,
            responseBody: responseBody,
            stackTrace: (error as dynamic).stackTrace as StackTrace?,
          );
      }
    }

    // Handle timeout errors (compatible with both old DioErrorType and new)
    final typeStr = (errorType as dynamic).toString();
    final stackTrace = (error as dynamic).stackTrace as StackTrace?;

    if (typeStr.contains('timeout')) {
      return NetworkFailure(message: 'Request timeout', stackTrace: stackTrace);
    }

    // Handle request cancellation
    if (typeStr.contains('cancel')) {
      return NetworkFailure(
        message: 'Request cancelled',
        stackTrace: stackTrace,
      );
    }

    // Handle connection errors
    if (typeStr.contains('connection') ||
        typeStr.contains('connectionError') ||
        typeStr.contains('unknown')) {
      return NetworkFailure(message: 'Network error', stackTrace: stackTrace);
    }

    // Default error
    return NetworkFailure(message: 'An error occurred', stackTrace: stackTrace);
  }

  /// Returns the underlying Dio instance for advanced usage
  Dio get dio => _dio;

  /// Closes the dio client
  void close() {
    _dio.close();
  }
}
