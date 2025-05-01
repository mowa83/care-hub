import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/hospital/services/hospitals_list_model.dart';
import 'package:graduation_project/screens/patient/hospital/services/hospitals_list_service.dart';
import 'package:graduation_project/screens/patient/hospital/widgets/app_hospital_card.dart';

class HospitalsListScreen extends StatefulWidget {
  const HospitalsListScreen({super.key, required this.governorate, required this.city});
  final String governorate;
  final String city;
  @override
  State<HospitalsListScreen> createState() => _HospitalsListScreenState();
}

class _HospitalsListScreenState extends State<HospitalsListScreen> {
  late final Future<List<HospitalsListModel>?> hospitalsFuture;
  @override
  void initState() {
    super.initState();
    hospitalsFuture = HospitalsListService().fetchHospitals(widget.city);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<List<HospitalsListModel>?>(
        future: hospitalsFuture,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError || snapshot.data == null) {
        return const Center(child: Text("Failed to load hospitals"));
      }

      final hospitals = snapshot.data!;
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
                return AppHospitalCard(
                    label: hospitals[index].name??'',
                    description:hospitals[index].address??'',
                    photo: hospitals[index].image??'',
              );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 5.h);
              },
              itemCount: hospitals.length,
              padding: EdgeInsets.only(bottom: 16.h,left:16.w,right: 16.w ),
            ),
          )
        ],
      );})
    );
  }
}
