import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/choose_city_body.dart';
class ChooseCityView extends StatelessWidget {
  const ChooseCityView({super.key,this.specialty, required this.governorate, required this.type});
  final String? specialty;
  final String governorate;
  final String type;
  @override
  Widget build(BuildContext context) {
    return  ChooseCityBody(specialty:specialty ,governorate:governorate, type: type ,);
  }
}
