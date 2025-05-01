import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurse_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NurseService {
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Authorization':
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc3MzgzNzQzLCJpYXQiOjE3NDQ5ODM3NDMsImp0aSI6IjA3MDUwZmEyNTMzMzQ4YTRiOGZhM2I1NWI3MmEzMTJhIiwidXNlcl9pZCI6MTV9.f9xgNJUwMr1_7EovPxsO5hLad_H_CiwckX4jas2LPns',
  };
  Future<NurseModel?> fetchNurse(int url) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/nurse/$url/"), headers: _headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return NurseModel.fromJson(data);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}