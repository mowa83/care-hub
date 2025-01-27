import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/home/presentation/views/choose_governorate_view.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_list_view.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_row.dart';

class ChooseSpecialtyBody extends StatelessWidget {
  const ChooseSpecialtyBody({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> specialties = ["Dental", "Dermatology", "Psychiatry"];
    final List<String> specialtiesIcons = [
      'assets/icons/tooth.svg',
      'assets/icons/dermatology.svg',
      'assets/icons/psychiatry.svg'
    ];
    return Scaffold(
      body: Column(
        children: [
          const ChooseRow(
            text: 'Choose Specialty',
          ),
          SizedBox(
            height: 35.h,
          ),
          ChooseListView(
            items: specialties,
            icons: specialtiesIcons,
            onItemTap: (index) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChooseGovernorateView(
                        specialty: specialties[index],
                      )));
            },
          )
        ],
      ),
    );
  }
}
