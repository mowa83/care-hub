import 'package:flutter/material.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/screens/patient/login/login_screen.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
        ));
      },
      style: const ButtonStyle(
          alignment: Alignment.centerLeft,
          fixedSize: WidgetStatePropertyAll(Size(130,48))),
      child: Text('Skip', style: textStyle16(letterSpacing: -.48)),
    );
  }
}
