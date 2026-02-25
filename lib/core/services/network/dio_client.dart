import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:expense_manager/core/constants/api_endpoints.dart';
import 'package:expense_manager/core/services/storage/preference_service.dart';

class DioClient {
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
        headers: {"Accept": "application/json"},
      ),
    );

    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_logInterceptor());
  }

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio _dio;

  Dio get client => _dio;

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = PreferencesService().token;

        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }

        return handler.next(options);
      },

      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          log("$error");
        }
        return handler.next(error);
      },
    );
  }

  Interceptor _logInterceptor() {
    return LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    );
  }
}
