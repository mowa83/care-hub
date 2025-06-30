import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/login/services/login_model.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(Login login) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/token/',
        data: login.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }

    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorData = e.response!.data;
        final errorMessage = errorData['detail'] ?? errorData.toString();
        throw Exception('Login failed: $errorMessage');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
