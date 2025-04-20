import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class DoctorsOffers extends StatelessWidget {
  const DoctorsOffers({super.key, required this.doctorName, required this.doctorSpecialty, required this.price, required this.offer});
  final String doctorName;
  final String doctorSpecialty;
  final int price;
  final int offer;
  @override
  Widget build(BuildContext context) {
    final double discountPercent = ((price - offer) / price) * 100;
    return Container(
      padding: EdgeInsets.only(top: 7.h,bottom: 7.h),
      width: 342.w,
      height: 81.h,
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
      child: Stack(
        // alignment: Alignment.center,
        children: [
          Positioned(
            left: 16.w,
            child: Image.asset(
              'assets/images/doctor_image.png',
              height: 67.h,
              width: 54.w,
            ),
          ),
          Positioned(
            left: 95.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  doctorName,
                  style: roboto14(),
                ),
                Text(
                  doctorSpecialty,
                  style: textStyle12(
                      color: const Color(0xff979797), letterSpacing: .07),
                ),
                Row(
                  children: [
                    Text(
                      '$price EGP',
                      style: textStyle10(letterSpacing: .03),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '$offer EGP',
                      style: nunitoSans14(letterSpacing: .1),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 12.w,
            child: Container(
              alignment: Alignment.center,
              width: 50.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColor.primarycolor,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Text(
                '${discountPercent.toStringAsFixed(0)}% Off',
                style: textStyle8(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
