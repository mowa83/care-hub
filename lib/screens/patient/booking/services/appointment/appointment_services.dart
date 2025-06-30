import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/patient/booking/services/appointment/appointment_model.dart';
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

  Future<List<AppointmentModel>> fetchPastAppointments() async {
    await init();
    try {
      final response = await _dio.get('/api/patient/appointments/past/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => AppointmentModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load past appointments: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load past appointments: $e');
    }
  }

  Future<List<AppointmentModel>> fetchUpcomingAppointments() async {
    await init(); 
    try {
      final response = await _dio.get('/api/patient/appointments/upcoming/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => AppointmentModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load upcoming appointments: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load upcoming appointments: $e');
    }
  }

  getAvailableSlots(int doctorId) {}
}
