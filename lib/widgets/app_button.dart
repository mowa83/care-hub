import 'package:flutter/material.dart';
import '../core/utils/colors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const AppButton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: AppText(
          title: title,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}
