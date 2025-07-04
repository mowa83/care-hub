import 'dart:convert';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:graduation_project/screens/patient/hospital/services/hospital_model.dart';
import 'package:http/http.dart' as http;

class HospitalService {
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
  Future<List<HospitalModel>?> fetchHospital(String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .get(Uri.parse('$baseUrl/hospital/api/departments/by-hospital/$url/'), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data.map((json) => HospitalModel.fromJson(json)).toList();
      } else {
        print("Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
