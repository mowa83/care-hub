import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    List profileItems = [
      {'icon': 'assets/icons/profile.svg', 'text': 'Menna Amir'},
      {'icon': 'assets/icons/calendar.svg', 'text': '02/12/2002'},
      {'icon': 'assets/icons/sms.svg', 'text': 'mennaamir@yahoo.com'},
      {'icon': 'assets/icons/call.svg', 'text': '0121202020'},
      {'icon': 'assets/icons/female.svg', 'text': 'Female'}
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 58),
                child: Text(
                  'Profile',
                  style: textStyle20(),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              SvgPicture.asset(
                'assets/icons/profile-circle.svg',
                width: 116.w,
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    width: 343.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffEBEBEB))),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 11.w, right: 8.w),
                          child: SvgPicture.asset(
                            profileItems[index]['icon']!,
                            colorFilter: const ColorFilter.mode(
                                Color(0xff292D32), BlendMode.srcIn),
                          ),
                        ),
                        Text(profileItems[index]['text']!,
                            style: textStyle12(fontSize: 16, height: 1.375))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 12.h,
                  );
                },
                itemCount: profileItems.length,
                padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Chronic Diseases',
                    style: textStyle12(fontSize: 14.sp),
                  )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 13.h),
                margin: EdgeInsets.only(bottom: 28.h, top: 12.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffEBEBEB))),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore",
                  style: textStyle12(height: 1.75),
                ),
              ),
              customButton(
                  func: () {

                  },
                  text: 'Logout',
                  textAlignment: MainAxisAlignment.start,
                  svgIcon: 'assets/icons/logout.svg',
                  letterSpacing: .09,fontWeight: FontWeight.w500,lineHeight:2),
              SizedBox(height: 50.h,)
            ],
          ),
        ),
      ),
    );
  }
}
