import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static const String _accessKey = 'access';
  static const String _userIdKey = 'user_id';
  static const String _profileIdKey = 'profile_id';
  static const String _userTypeKey = 'user_type';


  static Future<void> saveLoginData({
    required String access,
    required int userId,
    required String userType,
    required int profileId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, access);
    await prefs.setInt(_userIdKey, userId);
    await prefs.setInt(_profileIdKey, profileId);
    await prefs.setString(_userTypeKey, userType);
  }

  static Future<String?> getAccess() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessKey);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }
  static Future<int?> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_profileIdKey);
  }

  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userTypeKey);
    await prefs.remove(_profileIdKey);
  }
}