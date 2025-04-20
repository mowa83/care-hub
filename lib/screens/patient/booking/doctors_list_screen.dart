import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/booking/widgets/app_doctor_card.dart';

class DoctorsListScreen extends StatelessWidget {
  const DoctorsListScreen({super.key});


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
              AppDoctorCard(
                  labal: 'Aya Alashry',
                  description:
                      'Dental',
                  photo: 'Rectangle 1647'),
              AppDoctorCard(
                  labal: 'Aya Alashry',
                  description:
                      'Dental',
                  photo: 'Rectangle 1647'),
              AppDoctorCard(
                  labal: 'Aya Alashry',
                  description:
                      'Dental',
                  photo: 'Rectangle 1647'),
              AppDoctorCard(
                  labal: 'Aya Alashry',
                  description:
                      'Dental',
                  photo: 'Rectangle 1647'),
              AppDoctorCard(
                  labal: 'Aya Alashry',
                  description:
                      'Dental',
                  photo: 'Rectangle 1647'),
            ],
          ),
        ),
      ),
    );
  }
}