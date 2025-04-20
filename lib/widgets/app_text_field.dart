import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/utils/colors.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final String? Function(String? v)? validator;
  final bool secure;
  final TextEditingController? controller;
  const AppTextField({
    super.key,
    required this.hint,
    this.validator,
    this.secure = false,
    this.controller,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool secure = false;

  @override
  void initState() {
    secure = widget.secure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          cursorColor: AppColors.primary,
          validator: widget.validator,
          obscureText: secure,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 246, 246, 246),
            hintText: widget.hint,
            suffixIcon: widget.secure
                ? InkWell(
                    onTap: () => setState(() => secure = !secure),
                    child: Icon(
                      secure
                          ? FontAwesomeIcons.solidEyeSlash
                          : FontAwesomeIcons.solidEye,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  )
                : SizedBox(),
            hintStyle: TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            enabledBorder: getBorder(color: Colors.transparent),
            focusedBorder: getBorder(color: AppColors.primary),
            errorBorder: getBorder(color: AppColors.red),
            focusedErrorBorder: getBorder(color: AppColors.red),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder getBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }
}