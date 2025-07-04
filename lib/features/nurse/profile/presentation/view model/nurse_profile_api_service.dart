import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/features/nurse/profile/data/models/nurse_profile_model.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String url = '$baseUrl/api/user/';
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
  Future<ProfileModel?> fetchProfileModel() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse("${url}my_profile/"), headers: headers);

      // print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return ProfileModel.fromJson(data);
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

  Future<bool> updateProfile(ProfileModel updatedProfile) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(Uri.parse("${url}edit_my_profile/"),
          headers: headers, body: profileModelToJson(updatedProfile));

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
