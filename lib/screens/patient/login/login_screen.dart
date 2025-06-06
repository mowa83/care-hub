import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/features/patient/home/presentation/views/home_view.dart';
import 'package:graduation_project/screens/patient/login/forget_password_screen.dart';
import 'package:graduation_project/screens/patient/login/signup_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: AppText(
                    title: "Login",
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 40),
                AppHeadLine(photo: 'sms', labal: 'Email'),
                AppTextField(
                  controller: emailControler,
                  hint: 'Enter Your Email',
                  validator: Validator.email,
                ),
                SizedBox(height: 16),
                AppHeadLine(photo: 'lock', labal: 'password'),
                AppTextField(
                  controller: passwordControler,
                  hint: 'Enter Your Password',
                  secure: true,
                  validator: Validator.password,
                ),
                SizedBox(height: 8),
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
                    )),
                SizedBox(height: 30),
                AppButton(
                  title: 'Login',
                  onTap: () {
                    RouteUtils.push(context, HomeView());
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: "Don't have an account ?",
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    AppText(
                      title: ' let\'s Signup',
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      onTap: () =>
                          RouteUtils.pushReplacement(context, SignupScreen()),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
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
                            fontSize: 13),
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image(
                              image: AssetImage('assets/images/Facebook.png'))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image(
                              image:
                                  AssetImage('assets/images/Frame 36695.png'))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image(
                              image: AssetImage('assets/images/sms1.png'))),
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
