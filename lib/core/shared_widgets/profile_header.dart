import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {super.key, required this.isEditing, required this.onEditTap});
  final bool isEditing;
  final VoidCallback onEditTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 74.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              'Profile',
              style: textStyle20(),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
                onTap: onEditTap,
                child: Text(
                  isEditing ? 'Cancel' : 'EDIT',
                  style: textStyle16(
                      height: 1.5,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.primarycolor),
                )),
          ),
        ],
      ),
    );
  }
}
