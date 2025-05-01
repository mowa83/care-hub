import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/models/doctors_model.dart';
import 'package:graduation_project/core/services/doctors_api_service.dart';
import 'package:graduation_project/features/patient/all_offers/presentation/views/widgets/doctors_offers.dart';

class AllOffersBody extends StatefulWidget {
  const AllOffersBody({super.key});


  @override
  State<AllOffersBody> createState() => _AllOffersBodyState();
}

class _AllOffersBodyState extends State<AllOffersBody> {
  late final Future<List<Result>?> offerFuture;
  @override
  void initState() {
    super.initState();
    offerFuture = DoctorsApiService().fetchDoctors('has_offer=Yes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Result>?>(
            future: offerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load offers"));
              }

              final offer = snapshot.data!;
              return Column(
                children: [
                  HeaderRow(text: 'Our Offers'),
                  SizedBox(height:30.h),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 24,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (offer[index].offer!=null) {
                          return DoctorsOffers(
                            doctorName: offer[index].user?.username ?? '',
                            doctorSpecialty: offer[index].specialty?.name ?? '',
                            price: offer[index].price ?? 0,
                            offer: offer[index].offer!,
                            doctorId: offer[index].id!,
                            photo: offer[index].user?.image??'',
                          );
                        }
                        return null;
                      },
                      itemCount: offer.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only( bottom: 14.h,left:16.w,right: 16.w ),
                    ),
                  ),
                ],
              );
            }));
  }
}
