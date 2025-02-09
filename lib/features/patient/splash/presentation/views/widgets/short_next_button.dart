import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';

class ShortNextButton extends StatelessWidget {
  const ShortNextButton({super.key, required this.nextScreen});
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return customButton(
      func: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => nextScreen,
        ));
      },
      text: 'Next',
      height: 48.h,
      width: 130.w,
      letterSpacing: -.48,
      borderRadius: 10,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff003078).withOpacity(.10),
            offset: const Offset(0.0, 4), //(x,y)
            blurRadius: 30,
          ),
        ],
      ),
    );
  }
}
