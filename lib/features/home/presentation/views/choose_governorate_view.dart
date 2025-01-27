import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_governorate_body.dart';
class ChooseGovernorateView extends StatelessWidget {
  const ChooseGovernorateView({super.key, required this.specialty});
  final String specialty;
  @override
  Widget build(BuildContext context) {
    return  ChooseGovernorateBody(specialty: specialty,);
  }
}
