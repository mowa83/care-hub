import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/home/presentation/views/choose_specialty_view.dart';

class ServicesRoW extends StatelessWidget {
  const ServicesRoW({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.w,
      height: 77.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          servicesContainer(
              letterSpacing: .04,
              imageAsset: Image.asset(
                'assets/images/group_doctors.png',
                height: 41,
                width: 53,
              ),
              text: 'Book A Doctor',
              imagePaddingTop: 5,
              onItemTap:(){
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChooseSpecialtyView(),
                ));
              }

          ),
          servicesContainer(
              letterSpacing: .01,
              imageAsset: Image.asset(
                'assets/images/group_nurses.png',
                height: 54,
                width: 54,
              ),
              text: 'Home visit',
              onItemTap:(){
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChooseSpecialtyView(),
                ));
              }

          ),
          servicesContainer(
              letterSpacing: .01,
              imageAsset: Image.asset(
                'assets/images/hospital.png',
                height: 53,
                width: 53,
              ),
              text: '24 Hour',
              imagePaddingTop: 4,
              onItemTap:() {
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChooseSpecialtyView(),
                ));
              },

          )
        ],
      ),
    );
  }
}

Widget servicesContainer(
    {double? imagePaddingTop,
    required Image imageAsset,
    required String text,
    required double letterSpacing,
    required Function() onItemTap}) {
  return GestureDetector(
    onTap: () {
      onItemTap();
    },
    child: Container(
      width: 102.w,
      // height: 77,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.secondryColor,
      ),
      child: Stack(
        children: [
          Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: imagePaddingTop ?? 0),
              child: imageAsset),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 52),
            child: Text(
              text,
              style: textStyle12(fontSize: 10.sp, letterSpacing: letterSpacing),
            ),
          ),
        ],
      ),
    ),
  );
}
