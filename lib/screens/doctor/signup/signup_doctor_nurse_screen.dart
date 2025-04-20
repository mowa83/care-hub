import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/screens/doctor/signup/Verify_Signup_Doctor_Nurse.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/app_date_picker.dart';
import 'package:graduation_project/widgets/app_gender_picker.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';


class SignupDoctorNurseScreen extends StatefulWidget {
  const SignupDoctorNurseScreen({super.key});

  @override
  State<SignupDoctorNurseScreen> createState() => _SignupDoctorNurseScreenState();
}

class _SignupDoctorNurseScreenState extends State<SignupDoctorNurseScreen> {
  final formKey = GlobalKey<FormState>();
  bool check = false;
  String? validateCheckbox(bool? value) {
    if (value == false) {
      return 'You must agree to the terms and conditions';
    }
    return null;
  }
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 50),
            Center(
              child: AppText(
                title: 'Create Account',
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 40),
            AppHeadLine(photo: 'profile', labal: 'Full Name'),
            AppTextField(
              controller: fullNameController,
              hint: 'Enter Your Name',
              validator: Validator.fullName,
            ),
            SizedBox(
              height: 10,
            ),
            AppHeadLine(photo: 'sms', labal: 'Email'),
            AppTextField(
              controller: emailController,
              hint: 'Enter Your Email',
              validator: Validator.email,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'call', labal: 'Phone Number'),
            AppTextField(
              controller: phoneController,
              hint: 'Enter Your Mobile Number',
              validator: Validator.phone,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'password'),
            AppTextField(
              controller: passwordController,
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Confirm password'),
            AppTextField(
              controller: confirmPasswordController,
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
            ),
            SizedBox(
              height: 16,
            ),
            AppHeadLine(photo: 'lock', labal: 'Birth Of Date'),
            SizedBox(
              height: 3,
            ),
            AppDatePicker(
                hint: 'Enter Your Birth Date', validator: Validator.date),
            SizedBox(
              height: 16,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 5,
                ),
                AppText(
                    title: 'Gender', fontSize: 17, fontWeight: FontWeight.w500),
                AppText(
                    title: '*',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            AppGenderPicker(
              onGenderSelected: (gender) {
                setState(() => selectedGender = gender);
              },
              selectedGender: selectedGender,
              validator: (value) =>
                  selectedGender == null ? 'Please select a gender' : null,
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: check,
                      onChanged: (bool? value) {
                        setState(() {
                          check = value!;
                        });
                      },
                    ),
                    Row(
                      children: const [
                        AppText(
                          title: 'By Clicking, you agree to',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                        AppText(
                          title: ' Terms & Conditions',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                  ],
                ),
                FormField<bool>(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              state.errorText ?? '',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) => check == false
                      ? 'You must agree to the terms and conditions'
                      : null,
                ),
              ],
            ),
            SizedBox(height: 20),
            AppButton(
              title: 'Create',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  RouteUtils.push(context, VerifySignupDoctorNurseScreen());
                } else {
                  return;
                }
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
