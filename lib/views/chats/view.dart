import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/widgets/app_contact_card.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.all(16), children: [
        const HeaderRow(
          text: 'Chats',
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 246, 246, 246),
            prefixIcon: Padding(
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.search,
                size: 25,
                color: AppColors.grey,
              ),
            ),
            hintText: 'Search Chats ...',
            hintStyle: TextStyle(
              color: AppColors.grey,
              fontSize: 16,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            enabledBorder: getBorder(color: Colors.transparent),
            focusedBorder: getBorder(color: AppColors.primary),
            errorBorder: getBorder(color: AppColors.red),
            focusedErrorBorder: getBorder(color: AppColors.red),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        AppContactCard(),
        SizedBox(
          height: 25,
        ),
        AppContactCard(),
        SizedBox(
          height: 25,
        ),
        AppContactCard(),
        SizedBox(
          height: 25,
        ),
        AppContactCard(),
        SizedBox(
          height: 25,
        ),
        AppContactCard(),
      ]),
    );
  }
}

OutlineInputBorder getBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color),
  );
}
