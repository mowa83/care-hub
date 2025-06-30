import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';

class AppDropList extends FormField<String> {
  AppDropList({
    Key? key,
    required List<String> items,
    String? initialValue,
    required ValueChanged<String> onChanged,
    String? hintText,
    double iconSize = 24,
    double borderRadius = 13,
    double width = 150,
    String? Function(String?)? validator,
  }) : super(
          key: key,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<String> state) {
            return SizedBox(
              width: width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: state.hasError ? Colors.red : Colors.transparent,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.value,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down,
                        color: AppColors.primary, size: iconSize),
                    style:
                        TextStyle(color: AppColors.grey, fontSize: 16),
                    dropdownColor: AppColors.white,
                    hint: hintText != null
                        ? Text(hintText, style: TextStyle(color: AppColors.grey))
                        : null,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        state.didChange(newValue);
                        onChanged(newValue);
                      }
                    },
                    items: items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
}
