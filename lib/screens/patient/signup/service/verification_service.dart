import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';

class VerificationService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<bool> activateAccount(String code) async {
    try {
      final response = await _dio.post(
        '/api/Auth/activate/',
        data: {'code': code},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print(
            'Bad response: Status code ${response.statusCode}, Data: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      print('DioException: ${e.response?.data['message'] ?? e.message}');
      throw Exception(
          'Failed to activate account: ${e.response?.data['message'] ?? e.message}');
    }
  }
}
