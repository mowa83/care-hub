import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/screens/doctor/signup/doc_nurse_signup.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_date_picker.dart';
import 'package:graduation_project/widgets/app_gender_picker.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';

class SignupDoctorNurseScreen extends StatefulWidget {
  final String userType;
  const SignupDoctorNurseScreen({super.key, required this.userType});

  @override
  State<SignupDoctorNurseScreen> createState() =>
      _SignupDoctorNurseScreenState();
}

class _SignupDoctorNurseScreenState extends State<SignupDoctorNurseScreen> {
  final formKey = GlobalKey<FormState>();
  bool check = false;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  String? selectedGender;
  String? selectedBirthDate;

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
                title: 'Create Account (${widget.userType})',
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
            SizedBox(height: 10),
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
              //validator: Validator.phone,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Password'),
            AppTextField(
              controller: passwordController,
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Confirm Password'),
            AppTextField(
              controller: confirmPasswordController,
              hint: 'Confirm Your Password',
              secure: true,
              validator: (value) {
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return Validator.password(value);
              },
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'calendar', labal: 'Birth Date'),
            SizedBox(height: 3),
            AppDatePicker(
              controller: birthDateController,
              hint: 'Enter Your Birth Date',
              validator: Validator.date,
              onDateSelected: (apiDate) {
                setState(() {
                  selectedBirthDate = apiDate; 
                });
              },
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 4),
            AppGenderPicker(
              onGenderSelected: (gender) {
                setState(() => selectedGender = gender);
              },
              selectedGender: selectedGender,
              validator: (value) =>
                  selectedGender == null ? 'Please select a gender' : null,
            ),
            SizedBox(height: 16),
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
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                        AppText(
                          title: ' Terms & Conditions',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
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
                  if (selectedBirthDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a birth date.'),
                      ),
                    );
                    return;
                  }
                  final formData = {
                    'fullName': fullNameController.text,
                    'email': emailController.text,
                    'phone': phoneController.text,
                    'password': passwordController.text,
                    'birthDate': selectedBirthDate,
                    'gender': selectedGender,
                  };
                  RouteUtils.push(
                    context,
                    DocNurseSignup(
                      userType: widget.userType,
                      formData: formData,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

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
}
