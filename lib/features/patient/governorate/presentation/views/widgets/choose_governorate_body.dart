import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/constants/filters.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/patient/city/presentation/views/choose_city_view.dart';
import 'package:graduation_project/core/shared_widgets/choose_list_view.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';

class ChooseGovernorateBody extends StatefulWidget {
  const ChooseGovernorateBody({super.key, this.specialty, required this.type});
  final String? specialty;
  final String type;

  @override
  State<ChooseGovernorateBody> createState() => _ChooseGovernorateBodyState();
}

class _ChooseGovernorateBodyState extends State<ChooseGovernorateBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderRow(
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
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: ChooseListView(
              items: governorates,
              onItemTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChooseCityView(
                          governorate: governorates[index],
                          specialty: widget.specialty,
                          type: widget.type,
                        )));
              },
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
