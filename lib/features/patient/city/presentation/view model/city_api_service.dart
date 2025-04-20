import 'package:graduation_project/features/patient/city/data/models/city_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CityApiService {
  Future<CityModel?> fetchcities(String url) async {
    try {
      final response = await http.get( Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc2NzIzNDAwLCJpYXQiOjE3NDQzMjM0MDAsImp0aSI6IjJmYjYzZThiZjU3OTRlYzA5NGRhNmEyNGFlZDdhYjM5IiwidXNlcl9pZCI6MzB9.E6cBZJE7onngqu9PlbFv-5aEFNccvRa4pMtqLZrF8Zg', // إذا كان يحتاج مصادقة
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CityModel.fromJson(data);
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
