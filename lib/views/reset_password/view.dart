import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_row.dart';
import 'package:graduation_project/views/login/view.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:flutter/material.dart';
import '../../core/route_utils/route_utils.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_text_field.dart';

class CreatePasswordView extends StatelessWidget {
  CreatePasswordView({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            const ChooseRow(
              text: 'Verify Your Email',
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 40,
            ),
            Center(
                child: AppText(
              title: 'At least 9 characters, with uppercase,',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.grey,
            )),
            Center(
                child: AppText(
              title: 'lowercase letters and numbers',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.grey,
            )),
            SizedBox(height: 60),
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
            SizedBox(height: 40),
            AppButton(
              title: 'Send',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  RouteUtils.push(context, LoginView());
                } else {
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
