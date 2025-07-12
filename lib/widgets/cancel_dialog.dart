import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';

void showCancelAppointmentDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
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
              padding: EdgeInsets.only(top: 16.h, left: 18.w, right: 18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 3,),
                  AppText(
                    title: 
                    'Are you sure you want to cancel\n your appointment?',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customButton(
                        func: () {
                          Navigator.of(context).pop();
                        },
                        text: 'cancel',
                        height: 44.h,
                        width: 110.w,
                        borderRadius: 12,
                        backgroundColor: const Color(0xffF4F4F4),
                        textColor: Colors.black,
                        lineHeight: 2,
                      ),
                      customButton(
                        func: () {
                          Navigator.of(context).pop(); // Close dialog
                          onConfirm(); // Perform cancellation
                        },
                        text: 'Yes',
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
                  padding: EdgeInsets.only(left: 5.w),
                  child: SvgPicture.asset(
                    'assets/icons/save-2.svg',
                    height: 34.h,
                    width: 34.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
