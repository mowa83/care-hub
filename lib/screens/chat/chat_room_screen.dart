import 'package:flutter/material.dart';
import 'package:graduation_project/screens/chat/services/chat_services.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/chat/services/chat_model.dart';
import 'package:graduation_project/widgets/app_text.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    super.key,
    required this.chatId,
    required this.targetId,
    required this.targetName,
    required this.targetImage,
  });

  final int chatId;
  final int targetId;
  final String targetName;
  final String targetImage;

  @override
  ChatRoomScreenState createState() => ChatRoomScreenState();
}

class ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<HistoryChat> messages = [];
  String? errorMessage;
  final DateFormat dateFormat = DateFormat("MMM d 'at' hh:mm a");

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  DateTime tryParse(String? timestamp) {
    try {
      return dateFormat.parse(timestamp ?? '');
    } catch (e) {
      return DateTime(1970);
    }
  }

  Future<void> _fetchMessages() async {
    setState(() {
      errorMessage = null;
    });

    try {
      final chatService = ChatService();
      final fetchedMessages = await chatService.fetchChatHistory(widget.chatId);
      setState(() {
        messages = fetchedMessages;
        messages.sort(
          (a, b) => tryParse(a.timestamp).compareTo(tryParse(b.timestamp)),
        );
      });

      _scrollToBottom();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load messages: $e';
      });
    }
  }

  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      try {
        final chatService = ChatService();
        await chatService.sendMessage(widget.chatId, controller.text);
        controller.clear();
        await _fetchMessages();
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to send message: $e';
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 25,
              backgroundImage: widget.targetImage.isNotEmpty
                  ? NetworkImage(widget.targetImage)
                  : const AssetImage('assets/images/image.png')
                      as ImageProvider,
              onBackgroundImageError: (exception, stackTrace) =>
                  const Icon(Icons.error),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title: widget.targetName,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                // Row(
                //   children: const [
                //     Image(image: AssetImage('assets/images/Ellipse 12.png')),
                //     SizedBox(width: 3),
                //     AppText(
                //       title: 'Active Now',
                //       fontWeight: FontWeight.w300,
                //       fontSize: 12,
                //       color: AppColors.grey,
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: errorMessage != null
                ? Center(child: Text(errorMessage!))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      final isSentByUser =
                          message.senderName != widget.targetName;
                      return ListTile(
                        title: Align(
                          alignment: isSentByUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: isSentByUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isSentByUser
                                      ? AppColors.primary
                                      : AppColors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(isSentByUser ? 24 : 0),
                                    topRight:
                                        Radius.circular(isSentByUser ? 0 : 24),
                                    bottomLeft: const Radius.circular(24),
                                    bottomRight: const Radius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  message.content ?? '',
                                  style: TextStyle(
                                    color: isSentByUser
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  message.timestamp ?? '',
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              if (isSentByUser && message.isRead == true)
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.check,
                                      color: AppColors.primary,
                                      size: 15,
                                    )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      enabledBorder: getBorder(color: AppColors.grey),
                      focusedBorder: getBorder(color: AppColors.primary),
                      errorBorder: getBorder(color: AppColors.red),
                      focusedErrorBorder: getBorder(color: AppColors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Image(
                    image:
                        AssetImage('assets/images/Categories Icon Button.png'),
                  ),
                  iconSize: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder getBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide(color: color),
  );
}
