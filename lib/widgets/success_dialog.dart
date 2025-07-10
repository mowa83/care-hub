import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/signup/verify_signup_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

void showSuccessDialog({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 332.w,
              height: 154.h,
              padding: EdgeInsets.only(top: 16.h, left: 18.w, right: 18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  AppText(
                    title: 'Well Done!',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 15,),
                  Column(
                    children: [
                      AppText(
                        title: 'You successfully sent your request',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                      title: '   Wait For Us!! ',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                    ],
                  ),
                  
                ],
              ),
            ),
            Positioned(
              top: -22.h,
              left: 12.w,
              child: CircleAvatar(
                backgroundColor: AppColor.primarycolor,
                radius: 28.r,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: SvgPicture.asset(
                    'assets/icons/check.svg',
                    height: 38.h,
                    width: 38.w,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const VerifySignupScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.close, size: 24),
              ),
            ),
          ],
        ),
      );
    },
  );
}
