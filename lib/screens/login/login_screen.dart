import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/features/patient/home/presentation/views/home_view.dart'
    as patient;
import 'package:graduation_project/features/nurse/home/presentation/views/home_view.dart'
    as nurse;
import 'package:graduation_project/features/doctor/home/presentation/views/home_view.dart'
    as doctor;
import 'package:graduation_project/features/patient/splash/presentation/views/user_type_view.dart';
import 'package:graduation_project/screens/login/services/notification_token_service.dart';
import 'package:graduation_project/screens/reset_password/forget_password_screen.dart';
import 'package:graduation_project/screens/login/services/login_model.dart';
import 'package:graduation_project/screens/login/services/login_service.dart';
import 'package:graduation_project/screens/login/services/shared_login_prefs.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginService _authService = LoginService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      try {
        final login = Login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final response = await _authService.login(login);
        await SharedPrefsUtils.saveLoginData(
          access: response['access'],
          userId: response['user_id'],
          profileId: response['profile_id'],
          userType: response['user_type'],
        );
             // 🔔 تهيئة الإشعارات قبل الانتقال لأي شاشة
        await NotificationTokenService().initFCM();

            // (اختياري) استقبال الإشعار والتطبيق مفتوح
        FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
          print("📩 إشعار داخل التطبيق:");
          print("🔔 ${message.notification?.title}");
          print("📝 ${message.notification?.body}");
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;

          if (notification != null && android != null) {
            await flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'general_channel',
                  'Care-Hub Notifications',
                  channelDescription: 'Important Care-Hub alerts',
                  importance: Importance.max,
                  priority: Priority.high,
                  ticker: 'New urgent notification', // مهم لـ Heads-up
                  icon: '@drawable/ic_notification',
                  color:  AppColor.primarycolor,
                  playSound: true,
                  visibility: NotificationVisibility.public,
                  fullScreenIntent: true, // يظهر حتى مع الشاشة مغلقة
                  timeoutAfter: 5000,
                  styleInformation: BigTextStyleInformation(notification.body??''),
                ),
              ),
            );
          }
        });
        switch (response['user_type']) {
          case 'Patient':
            RouteUtils.pushReplacement(context, patient.HomeView());
            break;
          case 'Doctor':
            RouteUtils.pushReplacement(context, doctor.HomeView());
            break;
          case 'Nurse':
            RouteUtils.pushReplacement(context, nurse.HomeView());
            break;
          default:
            setState(() {
              errorMessage = 'Unknown user type: ${response['user_type']}';
            });
        }
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Center(
                  child: AppText(
                    title: "Login",
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 40),
                AppHeadLine(photo: 'sms', labal: 'Email'),
                AppTextField(
                  controller: emailController,
                  hint: 'Enter Your Email',
                  validator: Validator.email,
                ),
                const SizedBox(height: 16),
                AppHeadLine(photo: 'lock', labal: 'password'),
                AppTextField(
                  controller: passwordController,
                  hint: 'Enter Your Password',
                  secure: true,
                  // validator: Validator.password,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () =>
                        RouteUtils.push(context, ForgetPasswordScreen()),
                    child: Text(
                      'Forget Your Password?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : AppButton(
                        title: 'Login',
                        onTap: _login,
                      ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  AppText(
                    title: errorMessage!,
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                      title: "Don't have an account ?",
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    AppText(
                      title: " let's Signup",
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      onTap: () => RouteUtils.push(
                          context, const UserTypeView()),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      child: Text(
                        'Or Login with',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage('assets/images/Facebook.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage('assets/images/Frame 36695.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage('assets/images/sms1.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
