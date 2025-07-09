import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:http/http.dart' as http;

class NotificationTokenService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initFCM() async {
    print('🚀 initFCM بدأت');
    // طلب الإذن من المستخدم
    await _messaging.requestPermission();
    print('🔑 تم طلب الإذن');
    // الحصول على FCM Token
    String? token = await _messaging.getToken();
    print("📱 FCM Token: $token");

    // إرسال التوكن للسيرفر
    if (token != null) {
      print('🔹 هنبعت التوكن للسيرفر');
      await sendTokenToServer(token);
    }

    // متابعة تغيّر التوكن
    _messaging.onTokenRefresh.listen((newToken) {
      print("🔄 تم تحديث التوكن: $newToken");
      sendTokenToServer(newToken);
    });
  }

  Future<void> sendTokenToServer(String token) async {
    print('📨 sendTokenToServer بدأت');
    Future<String> getToken() async {
      final accessToken = await SharedPrefsUtils.getAccess();
      if (accessToken == null) {
        throw Exception('No token found');
      }

      return accessToken;
    }

    try {
      final accessToken = await getToken();
      await http.post(
        Uri.parse('$baseUrl/api/notifications/register-device/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: '{"registration_id": "$token","device_type": "android"}',
      );
      print('ok');
    } catch (e) {
      print('❌ Error: $e');
    }
  }
}
