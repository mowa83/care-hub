import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/screens/patient/booking/doctor_screen.dart';

class DoctorsOffers extends StatelessWidget {
  const DoctorsOffers(
      {super.key,
      required this.doctorName,
      required this.doctorSpecialty,
      required this.price,
      required this.offer,
      required this.doctorId,required this.photo,});
  final String doctorName;
  final String doctorSpecialty;
  final int price;
  final int offer;
  final int doctorId;
  final String photo;
  @override
  Widget build(BuildContext context) {
    final double discountPercent = ((price - offer) / price) * 100;
    return InkWell(
      onTap: () {
        RouteUtils.push(context, DoctorScreen(doctorId: doctorId,specialty: doctorSpecialty,));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h),
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
              child:  photo.isNotEmpty
                  ? Image.network(
                photo,
                  height: 67.h,
                  width: 57.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              )
                  : Icon(Icons.error),
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
      ),
    );
  }
}
