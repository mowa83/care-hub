import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField(
      {super.key,
      required this.controller,
      this.iconPath,
      this.onTap,
      required this.hintText,
      required this.isEditing,
      this.title});
  final TextEditingController controller;
  final String? iconPath;
  final VoidCallback? onTap;
  final String hintText;
  final String? title;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (iconPath == null)
          Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: Text(title!, style: textStyle12(fontSize: 14.sp)),
          ),
        TextField(
            minLines: iconPath == null ? 3 : 1,
            maxLines: null,
            controller: controller,
            enabled: isEditing && hintText != 'Email',
            onTap: onTap,
            style: textStyle12(
                fontSize: 14.sp,
                letterSpacing: .5,
                color: Color(0xff787B80),
                height: 1.7),
            decoration: InputDecoration(
                prefixIcon: iconPath != null
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          iconPath!,
                          colorFilter: const ColorFilter.mode(
                              Color(0xff292D32), BlendMode.srcIn),
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText,
                hintStyle: textStyle12(
                    letterSpacing: .5, color: Color(0xff787B80), height: 1.7))),
      ],
    );
  }
}
