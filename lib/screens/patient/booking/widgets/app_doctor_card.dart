import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/booking/doctor_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppDoctorCard extends StatelessWidget {
  final String labal;
  final String description;
  final String photo;

  const AppDoctorCard({
    super.key,
    required this.labal,
    required this.description,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(context, DoctorScreen());
      },
      child: Card(
        color: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(image: AssetImage('assets/images/$photo.png')),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AppText(
                        title: 'Dr. Aya Alashry',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      Divider(
                        height: 10,
                        indent: 10,
                        color: AppColors.black,
                      ),
                      AppText(
                        title: 'Dental',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                width: 67,
                height: 27,
                child: Center(
                    child: Text('100EGP',
                        style: TextStyle(color: AppColors.white))),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
