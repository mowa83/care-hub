import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_city_body.dart';
class ChooseCityView extends StatelessWidget {
  const ChooseCityView({super.key, required this.specialty, required this.governorate});
  final String specialty;
  final String governorate;
  @override
  Widget build(BuildContext context) {
    return  ChooseCityBody(specialty:specialty ,governorate:governorate ,);
  }
}
