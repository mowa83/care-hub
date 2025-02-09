import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class ChooseRow extends StatelessWidget {
  const ChooseRow({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 55.h),
      child: Stack(
        children: [
          Container(
            width: 34.w,
            height: 34,
            margin: EdgeInsets.only(left: 19.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: const Color(0xff212227).withOpacity(.12),
                    offset: const Offset(0, 2),
                  )
                ]),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.primarycolor,
                size: 14,
              ),
              padding: EdgeInsets.only(left: 6.w),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                text,
                style: textStyle18(height: 1.5, letterSpacing: .05),
              ),
            ),
          )
        ],
      ),
    );
  }
}
