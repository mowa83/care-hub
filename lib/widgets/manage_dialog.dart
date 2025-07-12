import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';

void showManageSlotDialog({
  required BuildContext context,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
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
              padding: EdgeInsets.fromLTRB(18.w, 32.h, 18.w, 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    title:
                        'Are you sure you want to edit or delete this slot?',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // customButton(
                      //   func: () => Navigator.of(context).pop(),
                      //   text: 'Cancel',
                      //   height: 44.h,
                      //   width: 100.w,
                      //   borderRadius: 12,
                      //   backgroundColor: const Color(0xffF4F4F4),
                      //   textColor: Colors.black,
                      //   lineHeight: 2,
                      // ),
                      customButton(
                        func: () {
                          Navigator.of(context).pop();
                          onEdit();
                        },
                        text: 'Edit',
                        height: 44.h,
                        width: 100.w,
                        borderRadius: 12,
                        lineHeight: 2,
                      ),
                      customButton(
                        func: () {
                          Navigator.of(context).pop();
                          onDelete();
                        },
                        text: 'Delete',
                        height: 44.h,
                        width: 100.w,
                        borderRadius: 12,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
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
