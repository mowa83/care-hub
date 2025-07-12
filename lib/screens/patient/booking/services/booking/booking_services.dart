import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:graduation_project/screens/patient/booking/services/booking/booking_models.dart';

class BookingService {
  final Dio _dio = Dio();

  BookingService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<void> init() async {
    final token = await SharedPrefsUtils.getAccess();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<List<AvailableSlotModel>> fetchAvailableSlots(
      int doctorId, DateTime startDate) async {
    await init();
    try {
      final response = await _dio.get('/api/doctor/$doctorId/available_slots/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => AvailableSlotModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load available slots: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load available slots: $e');
    }
  }

  Future<void> bookAppointment(BookAppointmentModel appointment) async {
    await init();
    try {
      final response = await _dio.post(
        '/api/book_appointment/',
        data: appointment.toJson(),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to book appointment: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
  }

  Future<void> updateAppointment(
      int appointmentId, BookAppointmentModel appointment) async {
    await init();
    try {
      final response = await _dio.put(
        '/api/appointment/$appointmentId/update/',
        data: appointment.toJson(),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update appointment: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

Future<void> cancelAppointment(int appointmentId) async {
  await init();
  try {
    final response = await _dio.delete(
      '/api/appointment/$appointmentId/cancel/',
    );
    if (response.statusCode != 200 && response.statusCode != 201 && response.statusCode != 204) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Failed to cancel appointment: ${response.statusCode}',
      );
    }
  } catch (e) {
    throw Exception('Failed to cancel appointment: $e');
  }
}
}