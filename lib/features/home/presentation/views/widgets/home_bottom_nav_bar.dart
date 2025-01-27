import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key, required this.currentIndex, this.onTap});
  final int currentIndex;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 32,
            color: Colors.black.withOpacity(.1),
            spreadRadius: 2,
            offset: const Offset(0, .5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            padding:
                const EdgeInsets.only(left: 9, top: 12, right: 16, bottom: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppColor.primarycolor,
            selectedIndex: currentIndex,
            onTabChange: onTap,
            textStyle: textStyle8(fontSize: 12, letterSpacing: .1),
            tabs: [
              GButton(
                leading: SvgPicture.asset(
                  'assets/icons/home.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 0 ? Colors.white : const Color(0xffAAACAE),
                    BlendMode.srcIn,
                  ),
                ),
                text: 'Home',
                icon: Icons.ice_skating,
                padding: const EdgeInsets.only(
                    left: 9, top: 11, right: 16, bottom: 11),
              ),
              GButton(
                leading: SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 1 ? Colors.white : const Color(0xffAAACAE),
                    BlendMode.srcIn,
                  ),
                ),
                text: 'Reservation',
                icon: Icons.account_circle,
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 11),
              ),
              GButton(
                leading: SvgPicture.asset(
                  'assets/icons/chats.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 2 ? Colors.white : const Color(0xffAAACAE),
                    BlendMode.srcIn,
                  ),
                ),
                text: 'chats',
                icon: Icons.add,
                padding: const EdgeInsets.only(
                    left: 6, top: 9, right: 19, bottom: 9),
              ),
              GButton(
                leading: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  colorFilter: ColorFilter.mode(
                    currentIndex == 3 ? Colors.white : const Color(0xffAAACAE),
                    BlendMode.srcIn,
                  ),
                ),
                text: 'Profile',
                icon: Icons.ice_skating,
                padding: const EdgeInsets.only(
                    left: 5, top: 9, right: 14, bottom: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
