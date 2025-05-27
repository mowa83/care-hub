import 'dart:convert';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/patient/hospital/services/hospitals_list_model.dart';
import 'package:http/http.dart' as http;
class HospitalsListService {
  Future<List<HospitalsListModel>?> fetchHospitals(String url) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/hospital/api/hospitals/by-city/$url/'), headers: {
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc2NzIzNDAwLCJpYXQiOjE3NDQzMjM0MDAsImp0aSI6IjJmYjYzZThiZjU3OTRlYzA5NGRhNmEyNGFlZDdhYjM5IiwidXNlcl9pZCI6MzB9.E6cBZJE7onngqu9PlbFv-5aEFNccvRa4pMtqLZrF8Zg', // إذا كان يحتاج مصادقة
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data.map((json) => HospitalsListModel.fromJson(json)).toList();

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