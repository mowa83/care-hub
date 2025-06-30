
import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/home_bottom_nav_bar.dart';
import 'package:graduation_project/features/doctor/profile/presentation/views/profile_view.dart';
import 'package:graduation_project/screens/doctor/booking/appointments_doctor_screen.dart';
import 'package:graduation_project/screens/doctor/booking/set_appointment_screen.dart';
import 'package:graduation_project/screens/chat/chats_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const AppointmentsDoctorScreen(),
    const SetAppointmentScreen(),
    const ChatsScreen(),
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
