import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurses_list_service.dart';
import 'package:graduation_project/screens/patient/home_visit/widgets/app_nurse_card.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurses_list_model.dart';
class NursesListScreen extends StatefulWidget {
  const NursesListScreen({super.key, required this.governorate, required this.city,
  });
  final String governorate;
  final String city;
  @override
  State<NursesListScreen> createState() => _NursesListScreenState();
}

class _NursesListScreenState extends State<NursesListScreen> {
  late final Future<List<Result>?> nursesFuture;
  @override
  void initState() {
    super.initState();
    nursesFuture = NursesListService().fetchNurses(
        'city=${widget.city}&city__governorate=${widget.governorate}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<List<Result>?>(
        future: nursesFuture,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError || snapshot.data == null) {
        return const Center(child: Text("Failed to load nurses"));
      }

      final nurses = snapshot.data!;
      return Column(
        children: [
          HeaderRow(
            text: '${widget.governorate}| ${widget.city}',
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return AppNurseCard(
                    label: nurses[index].user??'',
                    description:nurses[index].about??'',
                    photo:nurses[index].image??'',
                nurseId: nurses[index].id!,);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 5.h);
              },
              itemCount: nurses.length,
              padding: EdgeInsets.only(bottom: 16.h,left:16.w,right: 16.w ),
            ),
          )
        ],
      );})
    );
  }
}
