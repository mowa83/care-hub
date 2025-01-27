import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

Widget customButton({
  required Function() func,
  double? height,
  double? width,
  double? borderRadius,
  double? letterSpacing,
  double? lineHeight,
  Decoration? decoration,
  String? svgIcon,
  MainAxisAlignment? textAlignment,
  required String text,
  FontWeight?fontWeight
}) {
  return Container(
    height: height ?? 56.h,
    width: width ?? 342.w,
    decoration: decoration,
    child: MaterialButton(

      onPressed: func,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 14)),
      ),
      color: AppColor.primarycolor,
      elevation: 0,
      child: Row(
        mainAxisAlignment:textAlignment?? MainAxisAlignment.center,
        children: [
          if (svgIcon != null)
            Padding(
              padding:  EdgeInsets.only(right: 9.w),
              child: SvgPicture.asset(
                svgIcon,
              ),
            ),
          Text(text,
              style: textStyle16(
                  color: Colors.white,
                  letterSpacing: letterSpacing ?? -.30,
                  height: lineHeight,
              fontWeight:fontWeight )),

        ],
      ),
    ),
  );
}
