import 'dart:async';
import 'package:dio/dio.dart';

/// Interceptor for adding authentication tokens to requests
class AuthInterceptor extends Interceptor {
  /// Creates an [AuthInterceptor]
  AuthInterceptor({required this.getToken, this.refreshToken});

  /// Function that retrieves the current auth token
  final Future<String?> Function() getToken;

  /// Function to refresh the auth token
  final Future<String?> Function()? refreshToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      if (refreshToken != null) {
        try {
          final newToken = await refreshToken!();
          if (newToken != null) {
            // Retry the original request with new token
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';

            final response = await Dio().fetch<dynamic>(requestOptions);
            handler.resolve(response);
            return;
          }
        } catch (e) {
          // Token refresh failed, proceed with original error
        }
      }
      // Token refresh not available or failed
      // Could emit an event to navigate to login
    }
    handler.next(err);
  }
}
