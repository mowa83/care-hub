import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/core/models/doctor_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // static const String url = '$baseUrl/user/';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Authorization':
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc3MzgzNzQzLCJpYXQiOjE3NDQ5ODM3NDMsImp0aSI6IjA3MDUwZmEyNTMzMzQ4YTRiOGZhM2I1NWI3MmEzMTJhIiwidXNlcl9pZCI6MTV9.f9xgNJUwMr1_7EovPxsO5hLad_H_CiwckX4jas2LPns',
  };
  Future<DoctorProfileModel?> fetchProfileModel(String url) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api$url"), headers: _headers);

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
      final response = await http.put( Uri.parse("$baseUrl/api$url"),
          headers: _headers, body: doctorProfileModelToJson(updatedProfile));

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