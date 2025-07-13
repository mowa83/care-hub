import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/constants/filters.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/doctor/signup/services/signup_doctor_model.dart';
import 'package:graduation_project/screens/doctor/signup/services/signup_doctor_service.dart';
import 'package:graduation_project/screens/patient/signup/verify_signup_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_drop_list.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_image_picker.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/success_dialog.dart';


class DocNurseSignup extends StatefulWidget {
  final Map<String, dynamic> formData;
  final String userType;

  const DocNurseSignup({
    super.key,
    required this.formData,
    required this.userType,
  });

  @override
  State<DocNurseSignup> createState() => _DocNurseSignupState();
}

class _DocNurseSignupState extends State<DocNurseSignup> {
  final formKey = GlobalKey<FormState>();
  final Dio _dio = Dio();
  late final DoctorNurseSignupService _signupService;

  File? selectedImage;
  File? selectedCard;
  String? selectedGovernorate;
  String? selectedCity;
  String? selectedSpecialty;

  @override
  void initState() {
    super.initState();
    _signupService = DoctorNurseSignupService(_dio);
  }

Future<void> submitSignup() async {
  if (!formKey.currentState!.validate()) return;

  if (selectedImage == null || selectedCard == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select your photo and card.')),
    );
    return;
  }
  if (selectedGovernorate == null || selectedCity == null || selectedSpecialty == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select governorate, city, and specialty.')),
    );
    return;
  }

  final signupData = DoctorNurseSignupModel(
    username: widget.formData["fullName"],
    email: widget.formData["email"],
    password: widget.formData["password"],
    confirmPassword: widget.formData["password"],
    userType: widget.userType,
    gender: widget.formData["gender"],
    phoneNumber: widget.formData["phone"],
    birthDate: widget.formData["birthDate"],
    image: selectedImage!,
    card: selectedCard!,
    governorate: selectedGovernorate!,
    city: selectedCity!,
    specialty: selectedSpecialty!,
  );

  try {
    await _signupService.signupDoctorNurse(signupData);
    // Show the custom success dialog
    showSuccessDialog(context: context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            HeaderRow(text: 'Create Account'),
            const SizedBox(height: 40),
            AppHeadLine(photo: 'gallery', labal: 'Your Photo'),
            const SizedBox(height: 10),
            AppImagePicker(
              onImageSelected: (file) => setState(() => selectedImage = file),
            ),
            const SizedBox(height: 20),
            AppHeadLine(photo: 'gallery', labal: 'Your Card'),
            const SizedBox(height: 10),
            AppImagePicker(
              onImageSelected: (file) => setState(() => selectedCard = file),
            ),
            const SizedBox(height: 20),
            AppHeadLine(photo: 'location', labal: 'Location'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: AppDropList(
                    items: governorates,
                    hintText: 'Governorate',
                    onChanged: (value) => setState(() {
                      selectedGovernorate = value;
                      selectedCity = null;
                    }),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: AppDropList(
                    items: selectedGovernorate != null ? cities[selectedGovernorate!] ?? [] : [],
                    hintText: 'City',
                    onChanged: (value) => setState(() => selectedCity = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppHeadLine(photo: 'money', labal: 'Specialty'),
            const SizedBox(height: 10),
            AppDropList(
              items: specialties,
              hintText: 'Choose Your Specialty',
              onChanged: (value) => setState(() => selectedSpecialty = value),
            ),
            const SizedBox(height: 20),
            AppButton(
              title: 'Send',
              onTap: submitSignup,
            ),
          ],
        ),
      ),
    );
  }
}
