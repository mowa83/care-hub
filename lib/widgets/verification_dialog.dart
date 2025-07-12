import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';

void showVerificationDialog({
  required BuildContext context,
  required VoidCallback onContinue,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/Group 1261153172.png'),
                  height: 80.h, 
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16.h),
                AppText(
                  title: 'Congratulations!',
                  color: AppColors.primary,
                  fontSize: 24, 
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 8.h),
                AppText(
                  title: 'You have successfully created your account',
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      func: onContinue,
                      text: 'Continue',
                      height: 44.h,
                      width: 120.w,
                      borderRadius: 12,
                      lineHeight: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

