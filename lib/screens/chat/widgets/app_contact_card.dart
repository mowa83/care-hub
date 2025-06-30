import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/chat/chat_room_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppContactCard extends StatelessWidget {
  final String photo;
  final String label;
  final String lastMessage;
  final String timestamp;
  final int chatId;
  final int targetId;
  final String targetName;
  final String targetImage;

  const AppContactCard({
    super.key,
    required this.photo,
    required this.label,
    required this.lastMessage,
    required this.timestamp,
    required this.chatId,
    required this.targetId,
    required this.targetName,
    required this.targetImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.push(
          context,
          ChatRoomScreen(
            chatId: chatId,
            targetId: targetId,
            targetName: targetName,
            targetImage: targetImage,
          ),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: photo.isNotEmpty
                ? NetworkImage(photo)
                : AssetImage('assets/images/image.png') as ImageProvider,
            onBackgroundImageError: (exception, stackTrace) => Icon(Icons.error),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
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
                  title: lastMessage.isNotEmpty ? lastMessage : 'No messages yet',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            children: [
              AppText(
                title: timestamp.isNotEmpty ? _formatTimestamp(timestamp) : '',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              const SizedBox(height: 5),
              SizedBox(width: 23),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} min ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inDays} days ago';
      }
    } catch (e) {
      return timestamp;
    }
  }
}