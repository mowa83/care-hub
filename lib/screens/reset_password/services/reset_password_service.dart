import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/reset_password/services/reset_password_model.dart';

class ResetPasswordService {
  final Dio _dio = Dio();

  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/Auth/confirm_reset_password/',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to reset password: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Headers: ${e.response?.headers}');
      print('Message: ${e.message}');

      final errorData = e.response?.data;
      String? message;

      if (errorData is Map<String, dynamic>) {
        message = errorData['detail']?.toString() ?? errorData.toString();
      } else {
        message = errorData?.toString() ?? e.message;
      }

      throw Exception('Error resetting password: $message');
    } catch (e) {
      throw Exception('Error resetting password: $e');
    }
  }
}
