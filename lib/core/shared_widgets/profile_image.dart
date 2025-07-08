import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profileImageUrl});
  final String? profileImageUrl;
  static  Image img = Image.asset(
    'assets/images/doctor_profile.png',
    width: 87.w,
    height: 87.h,
    fit: BoxFit.cover,
  );
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: AppColor.secondryColor,
        radius: 43.5.r,
        child: ClipOval(
            child: profileImageUrl != null && profileImageUrl!.isNotEmpty
                ? Image.network(
                    'http://10.0.2.2:8000$profileImageUrl',
                    width: 87.w,
                    height: 87.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  )
                : Icon(Icons.error)));
  }
}
