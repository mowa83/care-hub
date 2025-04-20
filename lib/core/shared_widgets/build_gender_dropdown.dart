import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key, required this.isEditing, required this.selectedGender, required this.onChanged, required this.genderControllerText, required this.genderOptions});
  final bool isEditing;
  final String? selectedGender;
  final void Function(String?)? onChanged;
  final String genderControllerText;
  final List<String> genderOptions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        icon: isEditing
            ? const Icon(Icons.arrow_drop_down)
            : const SizedBox.shrink(),
        onChanged: isEditing
            ?onChanged
            : null,
        items: genderOptions.map((gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              genderControllerText == 'Male'
                  ? 'assets/icons/male.svg'
                  : 'assets/icons/female.svg',
              colorFilter:
              const ColorFilter.mode(Color(0xff292D32), BlendMode.srcIn),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isEditing ? Colors.black54 : Colors.black12,
            ),
          ),
          hintText: 'Gender',
          hintStyle: textStyle12(
              letterSpacing: .5, color: const Color(0xff787B80), height: 1.7),
        ),
      ),
    );
  }
}
