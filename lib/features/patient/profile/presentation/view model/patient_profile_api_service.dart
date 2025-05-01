import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/features/patient/profile/data/models/patient_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String url = '$baseUrl/api/user/';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc3MTk0OTQ0LCJpYXQiOjE3NDQ3OTQ5NDQsImp0aSI6ImZiZTY1OTIxYmU3MDQ3ZWViNTg3MTViNGJiODJjMGIyIiwidXNlcl9pZCI6MX0.ZKkLYSMlPMCSzV_h35yarHjcAJ68yLK4q8EoswbiOnc',
  };

  Future<PatientProfileModel?> fetchProfile() async {
    try {
      final response = await http.get(Uri.parse("${url}my_profile/"),
          headers: _headers);

      // print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return PatientProfileModel.fromJson(data);
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
  // Future<bool> updateProfile(PatientProfileModel updatedProfile) async {
  //   final url = Uri.parse("${baseUrl}edit_my_profile/");
  //   try {
  //     final response = await http.put(
  //         url,
  //         headers: _headers,
  //         body:  patientProfileModelToJson(updatedProfile)
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("Profile updated successfully");
  //       return true;
  //     } else {
  //       print("Update failed: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Exception during update: $e");
  //     return false;
  //   }
  // }
}