import 'package:graduation_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key});

  @override
  ChatRoomViewState createState() => ChatRoomViewState();
}

class ChatRoomViewState extends State<ChatRoomView> {
  final TextEditingController controller = TextEditingController();
  List<String> messages = [];

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add(controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/image.png'),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: 'Dr:Ahmed ',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Row(
                children: [
                  Image(image: AssetImage('assets/images/Ellipse 12.png')),
                  SizedBox(
                    width: 3,
                  ),
                  AppText(
                    title: 'Active Now',
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24)),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(color: Colors.white),
                      ),
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
                SizedBox(
                  width: 6,
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: Image(
                      image: AssetImage(
                          'assets/images/Categories Icon Button.png')),
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
