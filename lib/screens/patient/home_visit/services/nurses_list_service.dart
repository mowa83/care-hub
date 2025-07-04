import 'dart:convert';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:http/http.dart' as http;
import 'nurses_list_model.dart';
class NursesListService {
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
  Future<NursesListModel?> fetchNurses(String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .get(Uri.parse('$baseUrl/api/nurse/?$url'), headers:headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NursesListModel.fromJson(data);
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
