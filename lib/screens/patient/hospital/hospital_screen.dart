import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/hospital/services/hospital_model.dart';
import 'package:graduation_project/screens/patient/hospital/services/hospital_service.dart';
import 'package:graduation_project/screens/patient/hospital/widgets/app_department_card.dart';
import 'package:graduation_project/widgets/app_text.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key, required this.hospital});
  final String hospital;
  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  late final Future<List<HospitalModel>?> hospitalFuture;
  @override
  void initState() {
    super.initState();
    hospitalFuture = HospitalService().fetchHospital(widget.hospital);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<HospitalModel>?>(
            future: hospitalFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load"));
              }

              final hospital = snapshot.data!;
              return Column(
                children: [
                  HeaderRow(
                    text: 'Hospital Details',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hospital.isNotEmpty)
                          Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: hospital[0].hospital?.image != null &&
                                      hospital[0].hospital?.image.isNotEmpty
                                  ? Image.network(
                                      hospital[0].hospital?.image,
                                      width: 90.w,
                                      height: 90.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.error);
                                      },
                                    )
                                  : Icon(Icons.error),
                            ),
                        SizedBox(height: 12),
                        AppText(
                            title: hospital[0].hospital?.name ?? '',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image:
                                    AssetImage('assets/images/location.png')),
                            SizedBox(width: 5),
                            AppText(
                                title: hospital[0].hospital?.address ?? '',
                                fontSize: 14,
                                color: AppColors.black),
                          ],
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          child: AppText(
                              title: 'Hospital Department',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8),
                        ListView.separated(
                          itemBuilder: (context, index) {
                            return AppDepartmentCard(
                              departmentName: hospital[index].name ?? '',
                              workingHours:
                                  '${hospital[index].openingTime} - ${hospital[index].closingTime}',
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                                height: 12);
                          },
                          itemCount: hospital.length,
                          padding: EdgeInsets.only(bottom: 16.h),
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                        )
                      ],
                    ),],
                    ),
                  ),
                ],
              );
            }));
  }
}
