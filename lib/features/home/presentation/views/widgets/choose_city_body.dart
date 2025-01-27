import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_list_view.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_row.dart';
class ChooseCityBody extends StatelessWidget {
  const ChooseCityBody({super.key, required this.specialty, required this.governorate});
  final String specialty;
  final String governorate;
  @override
  Widget build(BuildContext context) {
    final List<String> cities = [
      "Alexandria",
      "Aswan",
      "Asyut",
      "Beheira",
      " Beni Suef",
      "Cairo",
      "Dakahlia",
      "Damietta",
      "Faiyum",
      "Gharbia"
    ];
    return Scaffold(
      body: Column(
        children: [
          const ChooseRow(
            text: 'Choose City',
          ),
          SizedBox(
            height: 35.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose Your Location",
                  style: textStyle18(
                      fontSize: 16.sp, height: 1.5, letterSpacing: .1),
                ),
                SvgPicture.asset('assets/icons/location.svg')
              ],
            ),
          ),
          SizedBox(height: 24.h,),
          ChooseListView(
            items: cities,
            onItemTap: (index) {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChooseCityView(
              //       governorate: governorate,
              //       specialty: specialty,
              //     )));
            },
            fontWeight:FontWeight.w400,
          )
        ],
      ),
    );
  }
}
