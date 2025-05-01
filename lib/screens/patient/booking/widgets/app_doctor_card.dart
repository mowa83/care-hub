import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/booking/doctor_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppDoctorCard extends StatelessWidget {
  final String label;
  final String specialty;
  final String description;
  final String? photo;
  final int price;
  final int doctorId;
  final int? offer;
  const AppDoctorCard({
    super.key,
    required this.label,
    required this.description,
    required this.photo,
    required this.price,
    this.offer, required this.doctorId, required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(context, DoctorScreen(doctorId: doctorId,specialty: specialty,));
      },
      child: Card(
        color: AppColors.white,
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photo != null && photo!.isNotEmpty
                  ? Image.network(
                      photo!,
                      width: 90.w,
                      height: 90.h,
                      fit: BoxFit.cover,
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
                      height: 10.h,
                      color: Colors.grey[350],
                    ),
                    AppText(
                      title: description,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        offer != null?
                          Text(
                            '$price EGP',
                            style: textStyle10(letterSpacing: .03,fontSize:14 ),
                          ):SizedBox(),
                        Container(
                          width: 67,
                          height: 27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primary,
                          ),
                          child: Center(
                              child: Text(
                                  offer != null ? '${offer}EGP' : '${price}EGP',
                                  style: TextStyle(color: AppColors.white))),
                        ),
                      ],
                    )
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
