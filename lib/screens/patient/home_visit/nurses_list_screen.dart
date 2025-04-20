import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/home_visit/widgets/app_nurse_card.dart';

class NursesListScreen extends StatelessWidget {
  const NursesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: const [
              HeaderRow(
                text: 'Cairo| October',
              ),
              SizedBox(
                height: 20,
              ),
              AppNurseCard(
                  labal: 'Aya Alashry',
                  description:
                      'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                  photo: 'Rectangle 1647'),
              AppNurseCard(
                  labal: 'Aya Alashry',
                  description:
                      'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                  photo: 'Rectangle 1647'),
              AppNurseCard(
                  labal: 'Aya Alashry',
                  description:
                      'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                  photo: 'Rectangle 1647'),
              AppNurseCard(
                  labal: 'Aya Alashry',
                  description:
                      'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                  photo: 'Rectangle 1647'),
              AppNurseCard(
                  labal: 'Aya Alashry',
                  description:
                      'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                  photo: 'Rectangle 1647'),
            ],
          ),
        ),
      ),
    );
  }
}
