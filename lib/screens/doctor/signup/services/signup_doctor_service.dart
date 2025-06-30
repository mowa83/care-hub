import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/doctor/signup/services/signup_doctor_model.dart';

class DoctorNurseSignupService {
  final Dio _dio;

  DoctorNurseSignupService(this._dio);

  Future<void> signupDoctorNurse(DoctorNurseSignupModel data) async {
    final formData = FormData.fromMap({
      "username": data.username,
      "email": data.email,
      "password": data.password,
      "confirm_password": data.confirmPassword,
      "user_type": data.userType,
      "gender": data.gender,
      "phone_number": data.phoneNumber,
      "birth_date": data.birthDate,
      "image": await MultipartFile.fromFile(data.image.path, filename: "profile.jpg"),
      "card": await MultipartFile.fromFile(data.card.path, filename: "card.jpg"),
      "governorate": data.governorate,
      "city": data.city,
      "specialty": data.specialty,
      "about": data.about,
      "services": data.services,
      "certificates": data.certificates,
      "price": data.price,
      "experience_year": data.experienceYear,
    });

    final response = await _dio.post(
      "$baseUrl/api/Auth/sign_up_doctor_nurse/",
      data: formData,
      options: Options(
        headers: {"Accept": "application/json"},
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Signup failed: ${response.statusCode}');
    }
  }
}
