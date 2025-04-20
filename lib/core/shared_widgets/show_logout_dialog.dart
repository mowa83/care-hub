import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/screens/patient/login/login_screen.dart';

void showLogoutDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none, // Allows elements to overflow
          children: [
            Container(
              width: 332.w,
              height: 154.h,
              padding: EdgeInsets.only(top: 16.h,left: 18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Are you want to logout?',
                    style: textStyle18(height: 1.2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customButton(
                        func: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel',
                        height: 44.h,
                        width: 110.w,
                        borderRadius: 12,
                        backgroundColor: Color(0xffF4F4F4),
                        textColor: Colors.black,
                        lineHeight: 2,
                      ),
                      customButton(
                        func: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        text: 'Logout',
                        height: 44.h,
                        width: 110.w,
                        borderRadius: 12,
                        lineHeight: 2,
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
                  padding:  EdgeInsets.only(left: 5.w),
                  child: SvgPicture.asset('assets/icons/logout.svg',height: 38.h,width: 38.w,),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
