import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/doctors_offers.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/our_offers_row.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/searchfor_doctor_stack.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/services_row.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/welcome_back_row.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeBackRow(),
                SizedBox(
                  height: 23.h,
                ),
                const SearchForDoctorStack(),
                Padding(
                  padding: EdgeInsets.only(top: 28.h, left: 1.w),
                  child: Text(
                    'What are you looking for?',
                    style: textStyle18(
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: .01),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const ServicesRoW(),
                SizedBox(
                  height: 40.h,
                ),
                const OurOffersRow(),
                SizedBox(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 24,
                      );
                    },
                    itemBuilder: (context, index) {
                      return const DoctorsOffers();
                    },
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
