import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/core/models/doctor_profile_model.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ApiService {
  Future<Map<String, String>> _getHeaders() async {
    final token = await SharedPrefsUtils.getAccess();
    if (token == null) {
      throw Exception('No token found');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  Future<DoctorProfileModel?> fetchProfileModel(String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse("$baseUrl/api$url"), headers: headers);

      // print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return DoctorProfileModel.fromJson(data);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      // print("$profileModel");
      return null;
    }
  }

  Future<bool> updateProfile(DoctorProfileModel updatedProfile,String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put( Uri.parse("$baseUrl/api$url"),
          headers: headers, body: doctorProfileModelToJson(updatedProfile));

      if (response.statusCode == 200) {
        print("Profile updated successfully");
        return true;
      } else {
        print("Update failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Exception during update: $e");
      return false;
    }
  }
}