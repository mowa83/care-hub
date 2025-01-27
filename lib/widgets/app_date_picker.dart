import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/utils/colors.dart';

class AppDatePicker extends StatefulWidget {
  final String hint;
  final String? Function(String? v)? validator;
  final bool secure;
  const AppDatePicker({
    super.key,
    required this.hint,
    this.validator,
    this.secure = false,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePicker2State();
}

class _AppDatePicker2State extends State<AppDatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        TextFormField(
          cursorColor: AppColors.primary,
          validator: widget.validator,
          controller: dateController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 246, 246, 246),
            hintText: widget.hint,
            suffixIcon: IconButton(
                onPressed: () async {
                  final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2025).add(Duration(days: 365)));
                  final formattedate = DateFormat('dd-MM-yyyy').format(date!);
                  setState(() {
                    dateController.text = formattedate.toString();
                  });
                },
                icon: Image(image: AssetImage('assets/images/calendar.png'))),
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
