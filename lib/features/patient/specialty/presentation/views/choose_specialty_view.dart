import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/specialty/presentation/views/widgets/choose_specialty_body.dart';
class ChooseSpecialtyView extends StatelessWidget {
  const ChooseSpecialtyView({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return  ChooseSpecialtyBody(type:type);
  }
}
