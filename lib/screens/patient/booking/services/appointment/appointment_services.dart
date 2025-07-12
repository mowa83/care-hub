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
      final List<dynamic> data = response.data;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Error: ${e.response?.data['detail'] ?? 'Could not fetch past appointments.'}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<AppointmentModel>> fetchUpcomingAppointments() async {
    await init();
    try {
      final response = await _dio.get('/api/patient/appointments/upcoming/');
      final List<dynamic> data = response.data;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Error: ${e.response?.data['detail'] ?? 'Could not fetch upcoming appointments.'}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<dynamic>> getAvailableSlots(int doctorId) async {
    await init();
    try {
      final response = await _dio.get('/api/slot/doctor/$doctorId/');
      return response.data;
    } on DioException catch (e) {
      throw Exception("Error: ${e.response?.data['detail'] ?? 'Could not fetch available slots.'}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
