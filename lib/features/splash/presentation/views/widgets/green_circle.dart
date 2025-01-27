import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/colors.dart';

class GreenCircle extends StatelessWidget {
  const GreenCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 151.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundColor: AppColor.primarycolor,
          radius: 129.r,
        ),
      ),
    );
  }
}
