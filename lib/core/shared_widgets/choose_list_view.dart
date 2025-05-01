import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class ChooseListView extends StatelessWidget {
  const ChooseListView({
    super.key,
    required this.items,
    required this.onItemTap,
    this.fontWeight,
    this.scrollController,
  });
  final List items;
  // final String icons;
  final ScrollController? scrollController;
  final Function(int index) onItemTap;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onItemTap(index);
          },
          child: Row(
            children: [
              // Padding(
              //   padding: EdgeInsets.only(right: 10.w),
              // child: Image.network(
              //   items[index].icon.replaceFirst('127.0.0.1', '10.0.2.2'),
              //   width: 40,
              //   height: 40,
              //   errorBuilder: (context, error, stackTrace) =>
              //       Icon(Icons.error),
              // ),
              // ),
              Text(
                items[index],
                style: textStyle18(
                    fontSize: 16.sp,
                    height: 1.5,
                    letterSpacing: .1,
                    fontWeight: fontWeight),
              ),
            ],
          ),
        );
      },
      controller: scrollController,
      itemCount: items.length,
      physics: const AlwaysScrollableScrollPhysics(),
      // shrinkWrap: true,
      padding: EdgeInsets.only(left: 16.w,bottom: 20.h),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 28.h,
        );
      },
    );
  }
}
