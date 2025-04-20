import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/city/presentation/views/widgets/choose_city_body.dart';
class ChooseCityView extends StatelessWidget {
  const ChooseCityView({super.key,this.specialty, required this.governorate, required this.type});
  final int? specialty;
  final int governorate;
  final String type;
  @override
  Widget build(BuildContext context) {
    return  ChooseCityBody(specialty:specialty ,governorate:governorate, type: type ,);
  }
}
