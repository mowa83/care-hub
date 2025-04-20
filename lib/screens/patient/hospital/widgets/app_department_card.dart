import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppDepartmentCard extends StatelessWidget {
  final String departmentName;
  final String workingHours;

  const AppDepartmentCard({
    super.key,
    required this.departmentName,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: '• $departmentName',
          fontSize: 16,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Image(image: AssetImage('assets/images/clock.png')),
            SizedBox(width: 6),
            AppText(title: 'From | ', fontSize: 14, color: AppColors.black),
            AppText(
                title: workingHours,
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500),
          ],
        ),
      ],
    );
  }
}