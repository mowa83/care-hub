import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class WelcomeBackRow extends StatelessWidget {
  const WelcomeBackRow({super.key, required this.patientName});
final String patientName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 69.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/profile-circle.svg',
            width: 34.w,
            // height: 36.h,
          ),
          SizedBox(width: 12.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: textStyle12(letterSpacing: .08),
              ),
              Text('Mr. $patientName',
                  style: textStyle12(
                    fontWeight: FontWeight.w500,
                    letterSpacing: .07,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
