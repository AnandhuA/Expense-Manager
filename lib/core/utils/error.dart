import 'package:dio/dio.dart';

class ErrorHelper {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      final response = error.response;

      if (response != null && response.data != null) {
        if (response.data is Map && response.data['message'] != null) {
          return response.data['message'].toString();
        }
      }

      // Handle Dio error types
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timed out. Please try again.';
        case DioExceptionType.sendTimeout:
          return 'Request timed out. Please try again.';
        case DioExceptionType.receiveTimeout:
          return 'Response timed out. Please try again.';
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.badResponse:
          return 'Server error: ${response?.statusCode}';
        case DioExceptionType.unknown:
          return 'Unknown error occurred. Check your internet connection.';
        default:
          return 'Something went wrong.';
      }
    }

    // Handle general exceptions
    if (error is String) return error;
    if (error is Exception) return error.toString();

    return 'Unexpected error occurred.';
  }
}
