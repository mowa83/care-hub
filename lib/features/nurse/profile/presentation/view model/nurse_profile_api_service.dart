import 'package:graduation_project/features/nurse/profile/data/models/nurse_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/user/';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc2NzIzNDAwLCJpYXQiOjE3NDQzMjM0MDAsImp0aSI6IjJmYjYzZThiZjU3OTRlYzA5NGRhNmEyNGFlZDdhYjM5IiwidXNlcl9pZCI6MzB9.E6cBZJE7onngqu9PlbFv-5aEFNccvRa4pMtqLZrF8Zg', // إذا كان يحتاج مصادقة
  };
  Future<ProfileModel?> fetchProfileModel() async {
    final url = Uri.parse("${baseUrl}my_profile/");
    try {
      final response = await http.get(url, headers: _headers);

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
    final url = Uri.parse("${baseUrl}edit_my_profile/");
    try {
      final response = await http.put(url,
          headers: _headers, body: profileModelToJson(updatedProfile));

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
