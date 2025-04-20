import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';

class AppDropList extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final double iconSize;
  final double borderRadius;
  final double width;

  const AppDropList({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChanged,
    this.hintText,
    this.iconSize = 24,
    this.borderRadius = 13,
    this.width = 150,
  });

  @override
  State<AppDropList> createState() => _AppDropListState();
}

class _AppDropListState extends State<AppDropList> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null &&
        widget.items.contains(widget.initialValue)) {
      selectedValue = widget.initialValue;
    } else {
      selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: Colors.transparent),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down,
                color: AppColors.primary, size: widget.iconSize),
            style: TextStyle(color: AppColors.grey, fontSize: 16),
            dropdownColor: AppColors.white,
            hint: widget.hintText != null
                ? Text(widget.hintText!,
                    style: TextStyle(color: AppColors.grey))
                : null,
            onChanged: widget.items.isEmpty
                ? null
                : (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedValue = newValue;
                      });
                      widget.onChanged(newValue);
                    }
                  },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
