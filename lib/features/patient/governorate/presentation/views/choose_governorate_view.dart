import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/governorate/presentation/views/widgets/choose_governorate_body.dart';
class ChooseGovernorateView extends StatelessWidget {
  const ChooseGovernorateView({super.key,  this.specialty, required this.type});
  final int? specialty;
  final String type;
  @override
  Widget build(BuildContext context) {
    return  ChooseGovernorateBody(type:type,specialty: specialty,);
  }
}
