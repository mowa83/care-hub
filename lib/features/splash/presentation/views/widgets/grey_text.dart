import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class GreyText extends StatelessWidget {
  const GreyText({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      // height: 96.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: const Color(0xff787B80),
            textStyle:
             const TextStyle(height: 1.5, letterSpacing: .5)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
