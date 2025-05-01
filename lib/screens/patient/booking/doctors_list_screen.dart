import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/booking/widgets/app_doctor_card.dart';
import '../../../core/models/doctors_model.dart';
import '../../../core/services/doctors_api_service.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen(
      {super.key,
      required this.specialty,
      required this.governorate,
       // required this.governorateName,
        required this.city,
        // required this.cityName
      });
  final String? specialty;
  final String governorate;
  final String city;
  // final String governorateName;
  // final String cityName;

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  late final Future<List<Result>?> doctorsFuture;
  @override
  void initState() {
    super.initState();
    doctorsFuture = DoctorsApiService().fetchDoctors(
        'city=${widget.city}&city__governorate=${widget.governorate}&specialty=${widget.specialty}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Result>?>(
            future: doctorsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load doctors"));
              }

              final doctors = snapshot.data!;
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

                          return AppDoctorCard(
                            label: doctors[index].user?.username ?? '',
                            description: doctors[index].specialty?.name ?? '',
                            photo: doctors[index].user?.image ??'',
                            price: doctors[index].price ?? 0,
                            offer: doctors[index].offer,
                            doctorId: doctors[index].id!,
                            specialty: doctors[index].specialty?.name??'',
                          );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5.h);
                      },
                      itemCount: doctors.length,
                      padding: EdgeInsets.only(
                          bottom: 16.h, left: 16.w, right: 16.w),
                    ),
                  ),
                ],
              );
            }));
  }
}
