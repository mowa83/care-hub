import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/views/chat_room/view.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppContactCard extends StatelessWidget {
  const AppContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(context, ChatRoomView());
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/image.png'),
            ),
            Column(
              children: [
                AppText(
                  title: 'Dr.Ahmed Yasser',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    AppText(
                      title: 'How are you today?',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 95,
            ),
            Column(
              children: [
                AppText(
                  title: '2 min ago',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Image(image: AssetImage('assets/images/Group 334.png')),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
