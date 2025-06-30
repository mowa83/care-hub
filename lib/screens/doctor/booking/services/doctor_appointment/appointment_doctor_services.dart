import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/doctor/booking/services/doctor_appointment/appointment_doctor_model.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';

class AppointmentService {
  final Dio _dio = Dio();

  AppointmentService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }
  Future<void> init() async {
    final token = await SharedPrefsUtils.getAccess();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<List<AppointmentDoctorModel>> fetchPastAppointments() async {
    await init();
    try {
      final response = await _dio.get('$baseUrl/api/doctor/appointments/past/');
      return (response.data as List)
          .map((json) => AppointmentDoctorModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch past appointments: $e');
    }
  }

  Future<List<AppointmentDoctorModel>> fetchUpcomingAppointments() async {
    await init();
    try {
      final response =
          await _dio.get('$baseUrl/api/doctor/appointments/upcoming/');
      return (response.data as List)
          .map((json) => AppointmentDoctorModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch upcoming appointments: $e');
    }
  }

  void dispose() {
    _dio.close();
  }
}
