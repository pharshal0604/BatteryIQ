// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ev_fleet_app/core/config/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dio HTTP client for EV Fleet Health
/// Single instance shared across all repositories via Riverpod
final dioProvider = Provider<Dio>((ref) {
  return ApiClient.instance;
});

class ApiClient {
  ApiClient._();

  // ==========================================================================
  // Singleton Instance
  // ==========================================================================

  static Dio get instance {
    final dio = Dio(_buildOptions());
    _attachInterceptors(dio);
    return dio;
  }

  // ==========================================================================
  // Base Options
  // ==========================================================================

  static BaseOptions _buildOptions() {
    return BaseOptions(
      baseUrl:        EnvConfig.fullApiUrl,
      connectTimeout: Duration(milliseconds: EnvConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: EnvConfig.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept':       'application/json',
      },
      validateStatus: (status) => status != null && status < 500,
    );
  }

  // ==========================================================================
  // Interceptors
  // ==========================================================================

  static void _attachInterceptors(Dio dio) {
    // 1. Network logger — only when enabled in .env
    if (EnvConfig.isNetworkLogsEnabled) {
      dio.interceptors.add(
        LogInterceptor(
          request:         true,
          requestBody:     true,
          requestHeader:   false,
          responseBody:    true,
          responseHeader:  false,
          error:           true,
          logPrint:        (obj) => print('[API] $obj'),
        ),
      );
    }

    // 2. Global error normalizer
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (EnvConfig.isDebugMode) {
            print('[API] → ${options.method} ${options.uri}');
          }
          handler.next(options);
        },

        onResponse: (response, handler) {
          if (EnvConfig.isDebugMode) {
            print('[API] ← ${response.statusCode} ${response.requestOptions.uri}');
          }
          handler.next(response);
        },

        onError: (DioException error, handler) {
          final message = _parseErrorMessage(error);
          final code    = _parseErrorCode(error);

          if (EnvConfig.isDebugMode) {
            print('[API] ✗ $code — $message');
          }

          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response:       error.response,
              type:           error.type,
              message:        message,
              error:          ApiException(code: code, message: message),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================================
  // Error Parsing
  // ==========================================================================

  static String _parseErrorMessage(DioException error) {
    // Try to extract message from Spring Boot error response body
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return data['message'] as String?
          ?? data['error'] as String?
          ?? _errorFromType(error);
    }
    return _errorFromType(error);
  }

  static String _errorFromType(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Check your network.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';
      case DioExceptionType.connectionError:
        return 'Cannot reach server. Is the backend running?';
      case DioExceptionType.badResponse:
        return 'Server error (${error.response?.statusCode}).';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        return error.message ?? 'Something went wrong.';
    }
  }

  static int _parseErrorCode(DioException error) {
    return error.response?.statusCode ?? 0;
  }
}

// ==========================================================================
// ApiException — thrown and caught in repositories
// ==========================================================================

class ApiException implements Exception {
  final int code;
  final String message;

  const ApiException({required this.code, required this.message});

  /// Whether the error is a network/connectivity issue
  bool get isNetworkError => code == 0;

  /// Whether the server returned Not Found
  bool get isNotFound => code == 404;

  /// Whether the server returned a server-side error
  bool get isServerError => code >= 500;

  @override 
  String toString() => 'ApiException($code): $message';
}
