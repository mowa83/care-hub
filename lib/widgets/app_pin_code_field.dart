import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../core/utils/colors.dart';

class AppPinCodeField extends StatelessWidget {
  final Function(String) onChanged;

  const AppPinCodeField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 80,
        fieldWidth: 80,
        activeColor: AppColors.grey,
        activeFillColor: Colors.transparent,
        inactiveColor: AppColors.grey,
        inactiveFillColor: Colors.transparent,
        selectedColor: AppColors.primary,
        selectedFillColor: Colors.transparent,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      onChanged: onChanged,
      appContext: context,
    );
  }
}