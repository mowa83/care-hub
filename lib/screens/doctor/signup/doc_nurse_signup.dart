import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/screens/patient/login/verify_signup_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_drop_list.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_image_picker.dart';
import 'package:graduation_project/widgets/app_text.dart';

class DocNurseSignup extends StatefulWidget {
  const DocNurseSignup({super.key});

  @override
  State<DocNurseSignup> createState() => _DocNurseSignupState();
}

class _DocNurseSignupState extends State<DocNurseSignup> {
  File? selectedImage;
  final formKey = GlobalKey<FormState>();
  void onImageSelected(File? image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: AppText(
                title: 'Create Account',
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 40),
            AppHeadLine(photo: 'gallery', labal: 'Your Photo'),
            SizedBox(
              height: 10,
            ),
            AppImagePicker(onImageSelected: onImageSelected),
            SizedBox(
              height: 20,
            ),
            AppHeadLine(photo: 'gallery', labal: 'Your Card'),
            SizedBox(
              height: 10,
            ),
            AppImagePicker(onImageSelected: onImageSelected),
            SizedBox(
              height: 20,
            ),
            AppHeadLine(photo: 'location', labal: 'Location'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AppDropList(
                    items: const ['cairo', 'banha', 'alexandria', 'giza'],
                    hintText: 'Government',
                    onChanged: (value) => print('Government: $value'),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: AppDropList(
                    items: const ['mansoura', 'mahala', 'nasr', 'tanta'],
                    hintText: 'City',
                    onChanged: (value) => print('City: $value'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AppHeadLine(photo: 'money', labal: 'specialty'),
            SizedBox(
              height: 10,
            ),
            AppDropList(
              items: const [
                'Dental',
                'Dermatology',
                'Psychiatry',
                'Dental',
                'Psychiatry',
              ],
              hintText: 'Choose Your specialty',
              onChanged: (value) => print('City: $value'),
            ),
            SizedBox(height: 20),
            AppButton(
              title: 'Send',
              onTap: () {
                RouteUtils.push(context, VerifySignupScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
