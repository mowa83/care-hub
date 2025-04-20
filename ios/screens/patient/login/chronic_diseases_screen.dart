import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/features/patient/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/patient/splash/presentation/views/widgets/short_next_button.dart';
import 'package:graduation_project/features/patient/splash/presentation/views/widgets/skip_button.dart';
import 'package:graduation_project/screens/patient/chat/chats_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';


class ChronicDiseasesScreen extends StatelessWidget {
  ChronicDiseasesScreen({super.key});
  final chronicDiseasesController = TextEditingController();

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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 800,
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
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
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
                                fillColor: Color.fromARGB(255, 246, 246, 246),
                                hintText: 'Enter Your chronic diseases',
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 70,
                                ),
                                enabledBorder:
                                    getBorder(color: Colors.transparent),
                                focusedBorder:
                                    getBorder(color: AppColors.primary),
                              ),
                            ),
                            SizedBox(height: 20,),
                            SizedBox(
                              width: 327,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SkipButton(),
                                  ShortNextButton(
                                    nextScreen: HomeView(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
