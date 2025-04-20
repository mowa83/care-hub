import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/home_visit/nurse_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppNurseCard extends StatelessWidget {
  final String labal;
  final String description;
  final String photo;

  const AppNurseCard({
    super.key,
    required this.labal,
    required this.description,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(context, NurseScreen());
      },
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: ClipRRect(
            child: Image(image: AssetImage('assets/images/$photo.png')),
          ),
          title:
              AppText(title: labal, fontSize: 17, fontWeight: FontWeight.w500),
          subtitle: AppText(title: description, color: AppColors.grey),
        ),
      ),
    );
  }
}
