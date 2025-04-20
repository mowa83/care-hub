import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/choose_row.dart';
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
              ChooseRow(
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