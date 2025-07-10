import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/signup/signup_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_text.dart';

class ChronicDiseasesScreen extends StatelessWidget {
  ChronicDiseasesScreen({super.key});
  final chronicDiseasesController = TextEditingController();

  InputBorder getBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 258,
                        height: 258,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                      Container(
                        width: 441,
                        height: 324,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/image 8.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    // Remove fixed height to allow content to size naturally
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey,
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: Offset(0, -8),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            title: 'Do you suffer from chronic diseases?',
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            textAlign: TextAlign.start,
                            controller: chronicDiseasesController,
                            cursorColor: AppColors.primary,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(255, 246, 246, 246),
                              hintText: 'Enter your chronic diseases',
                              hintStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 70,
                              ),
                              enabledBorder: getBorder(color: Colors.transparent),
                              focusedBorder: getBorder(color: AppColors.primary),
                            ),
                            // You can remove validator if it's optional
                            validator: (value) {
                              return null; // or implement your own rule
                            },
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: 130,
                              height: 48,
                              child: AppButton(
                                onTap: () {
                                  RouteUtils.push(
                                    context,
                                    SignupScreen(
                                      chronicDiseases: chronicDiseasesController.text,
                                    ),
                                  );
                                },
                                title: 'Next',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
