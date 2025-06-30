import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';

class VerifyPasswordServices {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<bool> activateAccount(String code) async {
    try {
      final response = await _dio.post(
        '/api/Auth/active_reset_password/',
        data: {'code': code},
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      print('DioException: ${e.response?.data ?? e.message}');
      throw Exception('Activation failed: ${e.response?.data?["message"] ?? e.message}');
    }
  }
}
