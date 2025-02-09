
import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/home_bottom_nav_bar.dart';
import 'package:graduation_project/features/doctor/home/presentation/views/widgets/home_body.dart';
import 'package:graduation_project/features/doctor/profile/presentation/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const HomeBody(),
    const HomeBody(),
    const HomeBody(),
    const ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: HomeBottomNavBar(
        calendarText: 'Appointments',
        nurse: false,
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: pages[selectedIndex],
    );
  }
}
