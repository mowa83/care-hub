import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/utils/colors.dart';

class AppDatePicker extends StatefulWidget {
  final String hint;
  final String? Function(String?)? validator;
  final bool secure;
  final TextEditingController? controller;
  final Function(String) onDateSelected;

  const AppDatePicker({
    super.key,
    required this.hint,
    this.validator,
    this.secure = false,
    this.controller,
    required this.onDateSelected,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      dateController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          cursorColor: AppColors.primary,
          validator: widget.validator,
          controller: dateController,
          readOnly: true,
          onTap: () async {
            final DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              final displayDate = DateFormat('dd-MM-yyyy').format(date);
              final apiDate = date.toUtc().toIso8601String();
              setState(() {
                dateController.text = displayDate;
              });
              widget.onDateSelected(apiDate);
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 246, 246, 246),
            hintText: widget.hint,
            suffixIcon: IconButton(
              onPressed: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  final displayDate = DateFormat('dd-MM-yyyy').format(date);
                  final apiDate = date.toUtc().toIso8601String();
                  setState(() {
                    dateController.text = displayDate;
                  });
                  widget.onDateSelected(apiDate);
                }
              },
              icon: const Image(
                image: AssetImage('assets/images/calendar.png'),
              ),
            ),
            hintStyle: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
            contentPadding: const EdgeInsets.symmetric(
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