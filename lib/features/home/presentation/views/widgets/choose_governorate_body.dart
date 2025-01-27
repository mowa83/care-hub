import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/home/presentation/views/choose_city_view.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_list_view.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_row.dart';

class ChooseGovernorateBody extends StatelessWidget {
  const ChooseGovernorateBody({super.key, required this.specialty});
  final String specialty;
  @override
  Widget build(BuildContext context) {
    final List<String> governorate = [
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
            text: 'Choose governorate',
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
            items: governorate,
            onItemTap: (index) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChooseCityView(
                        governorate: governorate[index],
                        specialty: specialty,
                      )));
            },
            fontWeight:FontWeight.w400,
          )
        ],
      ),
    );
  }
}
