import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:provider/provider.dart';

class AppGenderPicker extends StatelessWidget {
  const AppGenderPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GenderProvider>(
      create: (context) => GenderProvider(),
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Consumer<GenderProvider>(
                      builder: (context, genderProvider, _) => GestureDetector(
                        onTap: () {
                          genderProvider.isMale = false;
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 246, 246, 246),
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
                                SizedBox(
                                  width: 16,
                                ),
                                Image(
                                  image: AssetImage('assets/images/man.png'),
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                AppText(
                                  title: 'Male',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Consumer<GenderProvider>(
                      builder: (context, genderProvider, _) => GestureDetector(
                        onTap: () {
                          genderProvider.isMale = true;
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 246, 246, 246)),
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
                                SizedBox(
                                  width: 16,
                                ),
                                Image(
                                  image: AssetImage('assets/images/woman.png'),
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                AppText(
                                  title: 'Female',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class GenderProvider with ChangeNotifier {
  bool? _isMale;

  bool? get isMale => _isMale;

  set isMale(bool? value) {
    _isMale = value;
    notifyListeners();
  }

  get maleColor =>
      _isMale == true ? AppColors.primary : Color.fromARGB(255, 246, 246, 246);
  get femaleColor =>
      _isMale == false ? AppColors.primary : Color.fromARGB(255, 246, 246, 246);
}
