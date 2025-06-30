import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/reset_password/services/forget_password_model.dart';

class ForgetPasswordService {
  final Dio _dio = Dio();
  ForgetPasswordService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
    //_dio.options.headers['Authorization'] =
       // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc5Mzc0MDUyLCJpYXQiOjE3NDY5NzQwNTIsImp0aSI6IjYxYjU1ZjE2MzkyODQ3ODk4NDFmNzQ1YjY1NzA1YjkxIiwidXNlcl9pZCI6MX0.HYf7EA6vrSctkfPdMEguqKgxOA8FqAQURvD8i9GCwb0';
  }

  Future<void> sendResetPasswordEmail(ForgetPasswordModel request) async {
    const String url = '$baseUrl/api/Auth/reset_password/';
    try {
      final response = await _dio.post(
        url,
        data: request.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to send reset email');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'An error occurred while sending email.',
      );
    }
  }
}
