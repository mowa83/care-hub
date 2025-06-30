import 'package:flutter/material.dart';

import '../core/utils/colors.dart';

class AppText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color color;
  final TextDecoration? decoration;
  final void Function()? onTap;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? decorationColor;
  const AppText({
    super.key,
    required this.title,
    this.fontWeight,
    this.fontSize = 14,
    this.color = AppColors.black,
    this.decoration,
    this.onTap, this.maxLines, this.overflow,this.decorationColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
       maxLines: maxLines,
        overflow:overflow ,
      ),
    );
  }
}
