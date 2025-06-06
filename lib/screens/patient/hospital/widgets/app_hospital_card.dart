import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/hospital/hospital_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppHospitalCard extends StatelessWidget {
  final String label;
  final String description;
  final String? photo;
  const AppHospitalCard({
    super.key,
    required this.label,
    required this.description,
     this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(context, HospitalScreen(hospital: label,));
      },
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child:Padding(
          padding:  EdgeInsets.all(12.r),
          child: Row(
            children: [
              photo != null && photo!.isNotEmpty
                  ? Image.network(
                photo!,
                width: 90.w,
                height: 90.h,
                fit:BoxFit.cover ,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              )
                  : Icon(Icons.error),
               SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: label,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    Divider(
                      height: 20,
                      color: Colors.grey[350],
                    ),
                    AppText(
                      title: description,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGrey,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
