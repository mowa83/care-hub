import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class WelcomeBackRow extends StatelessWidget {
  const WelcomeBackRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 69.h),
      child: SizedBox(
        width: 132.w,
        // height: 36.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              'assets/icons/profile-circle.svg',
              width: 34.w,
              // height: 36.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: textStyle12(letterSpacing: .08),
                ),
                Text('Mr. Ahmed',
                    style: textStyle12(
                      fontWeight: FontWeight.w500,
                      letterSpacing: .07,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
