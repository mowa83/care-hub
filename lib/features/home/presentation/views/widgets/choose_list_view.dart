import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class ChooseListView extends StatelessWidget {
  const ChooseListView(
      {super.key, this.icons, required this.items, required this.onItemTap,this.fontWeight});
  final List<String> items;
  final List<String>? icons;
  final Function(int index) onItemTap;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onItemTap(index);
          },
          child: Row(
            children: [
              if (icons != null)
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(icons![index]),
                ),
              Text(
                items[index],
                style:
                    textStyle18(fontSize: 16.sp, height: 1.5, letterSpacing: .1,fontWeight:fontWeight),
              ),
            ],
          ),
        );
      },
      itemCount: items.length,
      padding: EdgeInsets.only(left: 16.w),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 28.h,
        );
      },
    ));
  }
}
