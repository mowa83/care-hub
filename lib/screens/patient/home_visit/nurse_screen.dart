import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/chat/chat_room_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class NurseScreen extends StatelessWidget {
  const NurseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            HeaderRow(
              text: 'Nurse Details',
            ),
            SizedBox(
              height: 20,
            ),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/image1.png'),
                  ),
                  SizedBox(height: 8),
                  AppText(
                    title: "Ahmed Yasser",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const AppText(
              title: "Phone Number",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Image(image: AssetImage('assets/images/call.png')),
                SizedBox(width: 8),
                AppText(
                  title: "01212102000",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const AppText(
              title: "About Me",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 4),
            const AppText(
              title:
                  "Lorem Ipsum Dolor Sit Amet Consectetur. Eget iaculis Est Cras Ornare Augue. Lorem Ipsum Dolor Sit Amet Consectetur",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
            const SizedBox(height: 20),
            const AppText(
              title: "Services",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 8),
            const AppText(
              title: ' •  Service1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const AppText(
              title: ' •  Service1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const AppText(
              title: ' •  Service1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const AppText(
              title: ' •  Service1',
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(height: 200),
            InkWell(
              onTap: () {
                RouteUtils.push(context, ChatRoomScreen());
              },
              child: Container(
                height: 65,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(image: AssetImage('assets/images/Group.png')),
                    AppText(
                      title: 'Chat',
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
