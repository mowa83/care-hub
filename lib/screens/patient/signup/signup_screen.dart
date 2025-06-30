import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/screens/patient/signup/service/signup_model.dart';
import 'package:graduation_project/screens/patient/signup/service/signup_services.dart';
import 'package:graduation_project/screens/patient/signup/verify_signup_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_date_picker.dart';
import 'package:graduation_project/widgets/app_gender_picker.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';

class SignupScreen extends StatefulWidget {
  final String? chronicDiseases;

  const SignupScreen({super.key, this.chronicDiseases});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool check = false;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  String? selectedGender;
  String? selectedBirthDateString; 

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  String? validateCheckbox(bool? value) {
    if (value == false) {
      return 'You must agree to the terms and conditions';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 50),
            const Center(
              child: AppText(
                title: 'Create Account',
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 40),
            AppHeadLine(photo: 'profile', labal: 'Full Name'),
            AppTextField(
              controller: fullNameController,
              hint: 'Enter Your Name',
              validator: Validator.fullName,
            ),
            const SizedBox(height: 10),
            AppHeadLine(photo: 'sms', labal: 'Email'),
            AppTextField(
              controller: emailController,
              hint: 'Enter Your Email',
              validator: Validator.email,
            ),
            const SizedBox(height: 16),
            AppHeadLine(photo: 'call', labal: 'Phone Number'),
            AppTextField(
              controller: phoneController,
              hint: 'Enter Your Mobile Number',
              validator: Validator.phone,
            ),
            const SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Password'),
            AppTextField(
              controller: passwordController,
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
            ),
            const SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Confirm Password'),
            AppTextField(
              controller: confirmPasswordController,
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
            ),
            const SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Birth Of Date'),
            const SizedBox(height: 3),
            AppDatePicker(
              hint: 'Enter Your Birth Date',
              controller: birthDateController,
              validator: Validator.date,
              onDateSelected: (dateString) {
                selectedBirthDateString = dateString; 
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                SizedBox(width: 5),
                AppText(
                  title: 'Gender',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  title: '*',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 4),
            AppGenderPicker(
              onGenderSelected: (gender) {
                setState(() => selectedGender = gender);
              },
              selectedGender: selectedGender,
              validator: (value) =>
                  selectedGender == null ? 'Please select a gender' : null,
            ),
            const SizedBox(height: 16),
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
                    const Expanded(
                      child: Wrap(
                        children: [
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FormField<bool>(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              state.errorText ?? '',
                              style: const TextStyle(
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
            const SizedBox(height: 20),
            AppButton(
              title: 'Create',
              onTap: () async {
                if (!formKey.currentState!.validate()) return;

                if (selectedBirthDateString == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a valid birth date."),
                    ),
                  );
                  return;
                }

                try {
                  final model = SignupModel(
                    username: fullNameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text,
                    confirmPassword: confirmPasswordController.text,
                    gender: selectedGender ?? '',
                    phoneNumber: int.tryParse(phoneController.text.trim()) ?? 0,
                    birthDate: selectedBirthDateString!,
                    chronicDiseases: widget.chronicDiseases ?? '',
                  );
                  final response = await SignupServices().signUpPatient(model);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    RouteUtils.push(context, const VerifySignupScreen());
                  }
                } on DioException catch (e) {
                  final errorData = e.response?.data;
                  String errorMessage = 'Signup failed. Please try again.';
                  if (errorData != null && errorData is Map<String, dynamic>) {
                    if (errorData.containsKey('detail')) {
                      final detail = errorData['detail'];
                      if (detail is List && detail.isNotEmpty) {
                        errorMessage = detail.first.toString();
                      } else if (detail is String) {
                        errorMessage = detail;
                      }
                    } else {
                      errorMessage =
                          errorData.entries.first.value[0].toString();
                    }
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                } catch (e) {
                  print('Unexpected exception: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('An unexpected error occurred.'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}