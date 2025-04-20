import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/home_body.dart';
import 'package:graduation_project/core/shared_widgets/home_bottom_nav_bar.dart';
import 'package:graduation_project/features/patient/profile/presentation/views/profile_view.dart';
import 'package:graduation_project/screens/patient/booking/doctors_list_screen.dart';
import 'package:graduation_project/screens/patient/chat/chat_room_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const HomeBody(),
    const DoctorsListScreen(),
    const ChatRoomScreen(),
    const ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: HomeBottomNavBar(
        calendarText: 'Reservation',
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
