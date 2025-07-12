import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_model.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';

class AddSlotsServices {
  final Dio _dio = Dio();
  int? _userId;

  AddSlotsServices() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<void> init() async {
    final token = await SharedPrefsUtils.getAccess();
    _userId = await SharedPrefsUtils.getProfileId();

    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<List<AvailableSlots>> fetchAvailableSlots() async {
    await init();
    if (_userId == null) {
      throw Exception('User ID is null');
    }

    try {
      final response = await _dio.get('/api/doctor/$_userId/available_slots/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => AvailableSlots.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception(
            'Failed to fetch weighted slots: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 404) {
        return [];
      }
      throw Exception('Error fetching available slots: $e');
    }
  }

  Future<AddSlots> addSlots(List<Map<String, dynamic>> slots) async {
    await init();
    try {
      final response = await _dio.post(
        '$baseUrl/api/api/doctor/add_slots/',
        data: jsonEncode(slots),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddSlots.fromJson(response.data);
      } else {
        throw Exception('Failed to add slots: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding slots: $e');
    }
  }

  Future<UpdateSlot> updateSlot(
      int slotId, Map<String, dynamic> slotData) async {
    await init();
    try {
      final response = await _dio.put(
        '$baseUrl/api/slot/$slotId/update/',
        data: jsonEncode(slotData),
      );
      if (response.statusCode == 200) {
        return UpdateSlot.fromJson(response.data);
      } else {
        throw Exception('Failed to update slot: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating slot: $e');
    }
  }

Future<void> cancelSlot(int slotId) async {
  await init();
  try {
    final response = await _dio.delete('$baseUrl/api/slot/$slotId/cancel/');
    if (response.statusCode != 200) {
      throw 'Failed to cancel slot: ${response.statusCode}';
    }
  } on DioError catch (e) {
    String? serverMessage;

    if (e.response?.data is Map && e.response?.data['error'] != null) {
      serverMessage = e.response?.data['error'];

      if (serverMessage == "لا يمكن حذف الموعد لأنه تم حجزه بالفعل") {
        serverMessage =
            "The appointment cannot be deleted because it has already been booked.";
      }
    } else {
      serverMessage = e.response?.data?.toString();
    }

    throw serverMessage ?? 'Failed to cancel slot.';
  } catch (e) {
    throw 'Unexpected error canceling slot.';
  }
}

}
