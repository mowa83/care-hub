import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/chat/chat_room_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppContactCard extends StatelessWidget {
  final String photo;
  final String label;

  const AppContactCard({
    super.key,
    required this.photo,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(context, ChatRoomScreen());
      },
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(photo),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title: label,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                const SizedBox(height: 5),
                AppText(
                  title: 'How are you today?',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ],
            ),
            SizedBox(
              width: 80,
            ),
            Column(
              children: const [
                AppText(
                  title: '2 min ago',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 23,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
