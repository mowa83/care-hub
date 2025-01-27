import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/home_body.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/home_bottom_nav_bar.dart';
import 'package:graduation_project/features/profile/presentation/views/profile_view.dart';
import 'package:graduation_project/views/chats/view.dart';

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
    const ChatView(),
    const ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: HomeBottomNavBar(
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
