import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class OurOffersRow extends StatelessWidget {
  const OurOffersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Our Offers',
            style:
                textStyle18(fontSize: 16.sp, height: 1.5, letterSpacing: .008),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  'View All',
                  style: textStyle12(color: AppColor.primarycolor),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: AppColor.primarycolor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
