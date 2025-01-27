import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/views/verify_your_email2/view.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/app_date_picker.dart';
import 'package:graduation_project/widgets/app_gender_picker.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import '../../core/utils/validator.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_text_field.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final formKey = GlobalKey<FormState>();
  bool check = false;
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
              hint: 'Enter Your Name',
              validator: Validator.fullName,
            ),
            SizedBox(
              height: 10,
            ),
            AppHeadLine(photo: 'sms', labal: 'Email'),
            AppTextField(
              hint: 'Enter Your Email',
              validator: Validator.email,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'call', labal: 'Phone Number'),
            AppTextField(
              hint: 'Enter Your Mobile Number',
              validator: Validator.phone,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'password'),
            AppTextField(
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
            ),
            SizedBox(height: 16),
            AppHeadLine(photo: 'lock', labal: 'Confirm password'),
            AppTextField(
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
            AppGenderPicker(),
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
                  RouteUtils.push(context, VerifyYourEmailView2());
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
