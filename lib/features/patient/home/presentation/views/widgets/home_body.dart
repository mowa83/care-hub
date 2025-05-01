import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/patient/all_offers/presentation/views/widgets/doctors_offers.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/our_offers_row.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/searchfor_doctor_stack.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/services_row.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/welcome_back_row.dart';
import 'package:graduation_project/features/patient/profile/data/models/patient_profile_model.dart';

import '../../../../../../core/models/doctors_model.dart';
import '../../../../../../core/services/doctors_api_service.dart';
import '../../../../profile/presentation/view model/patient_profile_api_service.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late Future<List<dynamic>> combinedFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    combinedFuture = Future.wait([
      DoctorsApiService().fetchDoctors('has_offer=Yes'),
      ApiService().fetchProfile(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<dynamic>>(
            future: combinedFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load the Profile"));
              }

              final List<Result>? offer = snapshot.data![0] as List<Result>?;
              final PatientProfileModel? patient = snapshot.data![1] as PatientProfileModel?;
              if (offer == null || patient == null) {
                return const Center(child: Text("Something went wrong"));
              }
              final topOffers = offer
                  .where((element) => element.offer != null)
                  .take(3)
                  .toList();
              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         WelcomeBackRow(patientName: patient.user?.username??'',),
                        SizedBox(
                          height: 23.h,
                        ),
                        const SearchForDoctorStack(),
                        Padding(
                          padding: EdgeInsets.only(top: 28.h, left: 1.w),
                          child: Text(
                            'What are you looking for?',
                            style: textStyle18(
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: .01),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const ServicesRoW(),
                        SizedBox(
                          height: 40.h,
                        ),
                        const OurOffersRow(),
                        SizedBox(
                          child: ListView.separated(

                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 24,
                              );
                            },
                            itemBuilder: (context, index) {

                                return DoctorsOffers(
                                  doctorName: topOffers[index].user?.username ?? '',
                                  doctorSpecialty:
                                  topOffers[index].specialty?.name ?? '',
                                  price: topOffers[index].price ?? 0,
                                  offer: topOffers[index].offer??0,
                                  doctorId: topOffers[index].id!,
                                  photo: topOffers[index].user?.image??'',
                                );
                            },
                            itemCount:topOffers.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 14, bottom: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
