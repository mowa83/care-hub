import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/home/presentation/views/choose_specialty_view.dart';

class SearchForDoctorStack extends StatelessWidget {
  const SearchForDoctorStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SvgPicture.asset(
        'assets/icons/green_card.svg',
        width: 342.w,
        // height: 143.h,
      ),
      Positioned(
          left: 204.w,
          bottom: 0,
          child: Image.asset(
            'assets/images/home_doctor.png',
            width: 133.w,
          )),
      Padding(
        padding: EdgeInsets.only(top: 20.h, left: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Looking For A\nDesired Doctor...?",
              style: textStyle20(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  // height: 1.5,
                  letterSpacing: .001),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: SizedBox(
                height: 28.h,
                width: 102.w,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChooseSpecialtyView(),
                    ));
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  color: Colors.white,
                  elevation: 0,
                  child: Text('Search For',
                      style: textStyle12(
                        letterSpacing: .06,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
