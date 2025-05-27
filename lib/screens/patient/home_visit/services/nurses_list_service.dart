import 'dart:convert';
import 'package:graduation_project/core/constants/config.dart';
import 'package:http/http.dart' as http;
import 'nurses_list_model.dart';
class NursesListService {
  Future<List<Result>?> fetchNurses(String url) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/nurse/?$url'), headers: {
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc2NzIzNDAwLCJpYXQiOjE3NDQzMjM0MDAsImp0aSI6IjJmYjYzZThiZjU3OTRlYzA5NGRhNmEyNGFlZDdhYjM5IiwidXNlcl9pZCI6MzB9.E6cBZJE7onngqu9PlbFv-5aEFNccvRa4pMtqLZrF8Zg', // إذا كان يحتاج مصادقة
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NursesListModel.fromJson(data).results;
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
