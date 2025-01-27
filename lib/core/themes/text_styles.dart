import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/core/themes/colors.dart';

TextStyle textStyle24({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    color: color ?? AppColor.primarycolor,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 24.sp,
    letterSpacing: letterSpacing,
    height: height,
  );
}

TextStyle textStyle20({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    color: color ?? Colors.black,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 20.sp,
    letterSpacing: letterSpacing,
    height: height??1.5,
  );
}

TextStyle textStyle18({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    color: color ?? Colors.black,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 18.sp,
    letterSpacing: letterSpacing,
    height: height,
  );
}

TextStyle textStyle16({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    color: color ?? AppColor.primarycolor,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 16.sp,
    letterSpacing: letterSpacing,
    height: height,
  );
}

TextStyle textStyle12({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    color: color ?? Colors.black,
    fontWeight: fontWeight ?? FontWeight.w400,
    fontSize: fontSize ?? 12.sp,
    letterSpacing: letterSpacing,
    height: height ?? 1.5,
  );
}

TextStyle textStyle10({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
    color: color ?? const Color(0xffBEBEBE),
    fontWeight: fontWeight ?? FontWeight.w400,
    fontSize: fontSize ?? 10.sp,
    letterSpacing: letterSpacing,
    height: height ?? 1.5,
    decoration: TextDecoration.lineThrough,
    decorationColor: const Color(0xffBEBEBE)
  );
}
TextStyle textStyle8({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.poppins(
      color: color ??  Colors.white,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 8.sp,
      letterSpacing: letterSpacing,
      height: height ?? 1.5,
  );
}

TextStyle roboto14({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.roboto(
    color: color ?? Colors.black,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 14.sp,
    letterSpacing: letterSpacing ?? .1,
    height: height ?? 1.4286,
  );
}

TextStyle nunitoSans14({
  double? fontSize,
  double? letterSpacing,
  double? height,
  Color? color,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.nunitoSans(
    color: color ?? AppColor.primarycolor,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 14.sp,
    letterSpacing: letterSpacing,
    height: height ?? 1.364,
  );
}
// TextStyle nunito16({
//   double? fontSize,
//   double? letterSpacing,
//   double? height,
//   Color? color,
//   FontWeight? fontWeight,
// }) {
//   return GoogleFonts.nunito(
//     color: color ?? Colors.black,
//     fontWeight: fontWeight ?? FontWeight.w400,
//     fontSize: fontSize ?? 16.sp,
//     letterSpacing: letterSpacing,
//     height: height ?? 1.375,
//   );
// }
