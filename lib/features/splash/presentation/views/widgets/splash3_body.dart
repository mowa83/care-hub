import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/splash/presentation/views/user_type_view.dart';
import 'package:graduation_project/features/splash/presentation/views/widgets/green_circle.dart';
import 'package:graduation_project/features/splash/presentation/views/widgets/green_rectangle.dart';
import 'package:graduation_project/features/splash/presentation/views/widgets/grey_circle.dart';
import 'package:graduation_project/features/splash/presentation/views/widgets/grey_text.dart';
import 'package:graduation_project/features/splash/presentation/views/widgets/short_next_button.dart';
import 'package:graduation_project/features/splash/presentation/views/widgets/skip_button.dart';
class Splash3Body extends StatelessWidget {
  const Splash3Body({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          const GreenCircle(),
          Container(
            margin: EdgeInsets.only(top: 38.h),
            child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/splash_doctor3.png',
                  height: 462.h,
                  width: 375.w,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 348.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff062E2A).withOpacity(.16),
                    offset: const Offset(0.0, -8), //(x,y)
                    blurRadius: 16.0,
                  ),
                ],
                color: Colors.white,
                // border: ,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 33.h),
                  SizedBox(
                    // height: 28.h,
                    child: Text(
                      ' Find Trusted Doctors ',
                      style: textStyle24(height: 1.17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const GreyText(
                      text:
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.'),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 8.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GreyCircle(),
                        SizedBox(width: 4.w),
                        const GreyCircle(),
                        SizedBox(width: 4.w),
                        const GreenRectangle(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 39.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    // height: 54,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [SkipButton(), ShortNextButton(nextScreen: UserTypeView(),)],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
