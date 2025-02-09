import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GreyCircle extends StatelessWidget {
  const GreyCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundColor: const Color(0xffD9D9D9),
      maxRadius: 4.r,
    );
  }
}
