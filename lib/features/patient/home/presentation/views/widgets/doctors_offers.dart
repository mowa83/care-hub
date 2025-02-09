import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class DoctorsOffers extends StatelessWidget {
  const DoctorsOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 7.h,bottom: 7.h),
      width: 342.w,
      // height: 81.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(.06),
            offset: const Offset(0.0, 4), //(x,y)
            blurRadius: 4,
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w,right: 25.w),
            child: Image.asset(
              'assets/images/doctor_image.png',
              height: 67.h,
              width: 54.w,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dr Ahmed Yasser',
                style: roboto14(),
              ),
              Text(
                'Dentist',
                style: textStyle12(
                    color: const Color(0xff979797), letterSpacing: .07),
              ),
              Row(
                children: [
                  Text(
                    '300 EGP',
                    style: textStyle10(letterSpacing: .03),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '200 EGP',
                    style: nunitoSans14(letterSpacing: .1),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 73.w),
            child: Container(
              alignment: Alignment.center,
              width: 50.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColor.primarycolor,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Text(
                '30% Off',
                style: textStyle8(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
