import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/patient/specialty/data/models/specialty_model.dart';
import 'package:graduation_project/features/patient/specialty/presentation/view%20model/specialty_api_service.dart';
import 'package:graduation_project/features/patient/governorate/presentation/views/choose_governorate_view.dart';
import 'package:graduation_project/core/shared_widgets/choose_list_view.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';

import '../../../../../../core/constants/filters.dart';


class ChooseSpecialtyBody extends StatelessWidget {
  const ChooseSpecialtyBody({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      //   FutureBuilder<List<Result>?>(
    //     future: SpecialtyApiService().fetchSpecialties(),
    // builder: (context, snapshot) {
    // if (snapshot.connectionState == ConnectionState.waiting) {
    // return const Center(child: CircularProgressIndicator());
    // } else if (snapshot.hasError || snapshot.data == null) {
    // return const Center(child: Text("Failed to load specialties"));
    // }
    //
    // final specialty = snapshot.data!;
    // return
      Column(
        children: [
          const HeaderRow(
            text: 'Choose Specialty',
          ),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
            child: ChooseListView(
              items: specialties,
              // icons: specialty[index].icon,
              onItemTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChooseGovernorateView(
                          specialty:specialties[index],
                      type: type,
                        )));
              },
            ),
          )
        ],
      )
    // ;
        // })
    );
  }
}
