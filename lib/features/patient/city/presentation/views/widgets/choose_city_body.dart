import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/constants/filters.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/core/shared_widgets/choose_list_view.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/booking/doctors_list_screen.dart';
import 'package:graduation_project/screens/patient/home_visit/nurses_list_screen.dart';
import 'package:graduation_project/screens/patient/hospital/hospitals_list_screen.dart';

class ChooseCityBody extends StatefulWidget {
  const ChooseCityBody(
      {super.key,
      this.specialty,
      required this.governorate,
      required this.type});
  final String? specialty;
  final String governorate;
  final String type;

  @override
  State<ChooseCityBody> createState() => _ChooseCityBodyState();
}

class _ChooseCityBodyState extends State<ChooseCityBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderRow(
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
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: ChooseListView(
              items: cities[widget.governorate]!,
              onItemTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    if (widget.type == 'hospital') {
                      return HospitalsListScreen(
                        governorate: widget.governorate,
                        city: cities[widget.governorate]![index],
                      );
                    } else if (widget.type == "nurse") {
                      return NursesListScreen(
                        governorate: widget.governorate,
                        city: cities[widget.governorate]![index],
                      );
                    } else {
                      return DoctorsListScreen(
                        governorate: widget.governorate,
                        specialty: widget.specialty,
                        city: cities[widget.governorate]![index],
                      );
                    }
                  },
                ));
              },
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
