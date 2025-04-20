import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';

class ProfileBottomButton extends StatelessWidget {
  const ProfileBottomButton(
      {super.key,
      required this.isEditing,
      required this.onSave,
      required this.onLogout});
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback onLogout;
  @override
  Widget build(BuildContext context) {
    return isEditing
        ? customButton(
            func: onSave,
            text: 'Save',
            textAlignment: MainAxisAlignment.center,
            letterSpacing: .09,
            fontWeight: FontWeight.w500,
            lineHeight: 2)
        : customButton(
            func: onLogout,
            text: 'Logout',
            textAlignment: MainAxisAlignment.start,
            svgIcon: 'assets/icons/logout.svg',
            letterSpacing: .09,
            fontWeight: FontWeight.w500,
            lineHeight: 2);
  }
}
