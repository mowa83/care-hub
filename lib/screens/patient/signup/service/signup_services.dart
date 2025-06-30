import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/patient/signup/service/signup_model.dart';

class SignupServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Response> signUpPatient(SignupModel data) async {
    try {
      print("Sending data: ${data.toJson()}");
      final response = await _dio.post('/api/Auth/sign_up_patient/', data: data.toJson());
      return response;
    } catch (e) {
      if (e is DioException) {
        print('Signup failed: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
      rethrow;
    }
  }
}
