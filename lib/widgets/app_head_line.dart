import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppHeadLine extends StatelessWidget {
  String photo;
  String labal;
  AppHeadLine({
    super.key,
    required this.photo,
    required this.labal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(image: AssetImage('assets/images/$photo.png')),
        SizedBox(
          width: 5,
        ),
        AppText(title: labal, fontSize: 17, fontWeight: FontWeight.w500),
        AppText(
            title: '*',
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: AppColors.primary),
      ],
    );
  }
}
