import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/choose_row.dart';
import 'package:graduation_project/screens/patient/booking/booking_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ChooseRow(
              text: 'Doctor Details',
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/image1.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: 'Dr. Ahmed Yasser',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 4),
                    AppText(
                      title: 'Cardiologist',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/Group 15.png'),
                    ),
                    AppText(
                      title: '200EGP',
                      color: AppColors.primary,
                    ),
                    AppText(title: 'Price'),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/Group 15 (1).png'),
                    ),
                    AppText(
                      title: '10+',
                      color: AppColors.primary,
                    ),
                    AppText(title: 'years exper..'),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/Group 15 (2).png'),
                    ),
                    AppText(
                      title: '01212130030',
                      color: AppColors.primary,
                    ),
                    AppText(title: 'Phone Number'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const AppText(
              title: 'Working Time',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.access_time, color: AppColors.primary),
                SizedBox(width: 8),
                AppText(
                  title: 'Monday - Friday | 08:00 - 20:00 PM',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const AppText(
              title: 'About Me',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            const AppText(
              title:
                  'Lorem ipsum dolor sit amet consectetur. Eget iaculis est cras ornare augue. Lorem ipsum dolor sit amet consectetur',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 24),
            const Text(
              'Certificates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const AppText(
              title: '• Certificate1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const AppText(
              title: '• Certificate1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const AppText(
              title: '• Certificate1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                RouteUtils.push(context, BookingScreen());
              },
              child: Container(
                height: 65,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AppText(
                      title: 'Book Appointement',
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
