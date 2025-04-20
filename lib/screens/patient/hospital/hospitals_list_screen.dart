import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/choose_row.dart';
import 'package:graduation_project/screens/patient/hospital/widgets/app_hospital_card.dart';

class HospitalsListScreen extends StatelessWidget {
  const HospitalsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: const [
            ChooseRow(
              text: 'Cairo| October',
            ),
            SizedBox(
              height: 20,
            ),
            AppHospitalCard(
                labal: 'Hospital Name',
                description:
                    'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                photo: 'hos'),
            AppHospitalCard(
                labal: 'Hospital Name',
                description:
                    'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                photo: 'hos'),
            AppHospitalCard(
                labal: 'Hospital Name',
                description:
                    'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                photo: 'hos'),
            AppHospitalCard(
                labal: 'Hospital Name',
                description:
                    'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                photo: 'hos'),
            AppHospitalCard(
                labal: 'Hospital Name',
                description:
                    'Lorem ipsum dolor sit bag dhj sit amet consectetur jauhn... ',
                photo: 'hos'),
          ],
        ),
      ),
    );
  }
}
