import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/colors.dart';
class GreenRectangle extends StatelessWidget {
  const GreenRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      height: 6.h,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColor.primarycolor,
          borderRadius:
          BorderRadius.all(Radius.circular(10.r))),
    );
  }
}
