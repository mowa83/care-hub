import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:provider/provider.dart';

class AppGenderPicker extends StatelessWidget {
  final Function(String)? onGenderSelected;
  final String? selectedGender;
  final String? Function(String?)? validator;

  const AppGenderPicker({
    super.key,
    this.onGenderSelected,
    this.selectedGender,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GenderProvider>(
      create: (context) => GenderProvider(selectedGender: selectedGender),
      child: FormField<String>(
        initialValue: selectedGender,
        validator: validator,
        builder: (FormFieldState<String> state) {
          return Consumer<GenderProvider>(
            builder: (context, genderProvider, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          genderProvider.selectGender('Male');
                          state.didChange('Male');
                          if (onGenderSelected != null) {
                            onGenderSelected!('Male');
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 246, 246, 246),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: genderProvider.maleColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(width: 16),
                                Image(
                                  image: AssetImage('assets/images/man.png'),
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 7),
                                AppText(
                                  title: 'Male',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          genderProvider.selectGender('Female');
                          state.didChange('Female');
                          if (onGenderSelected != null) {
                            onGenderSelected!('Female');
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 246, 246, 246),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: genderProvider.femaleColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(width: 16),
                                Image(
                                  image: AssetImage('assets/images/woman.png'),
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 6),
                                AppText(
                                  title: 'Female',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 2),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GenderProvider with ChangeNotifier {
  String? _selectedGender;

  GenderProvider({String? selectedGender}) : _selectedGender = selectedGender;

  String? get selectedGender => _selectedGender;

  void selectGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  Color get maleColor =>
      _selectedGender == 'Male' ? AppColors.primary : const Color.fromARGB(255, 246, 246, 246);

  Color get femaleColor =>
      _selectedGender == 'Female' ? AppColors.primary : const Color.fromARGB(255, 246, 246, 246);
}