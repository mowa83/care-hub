import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/features/patient/all_offers/data/models/offers_model.dart';
import 'package:graduation_project/features/patient/all_offers/presentation/view%20model/offers_api_service.dart';
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
    // TODO: implement initState
    super.initState();
    offerFuture = OffersApiService().fetchOffers();
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
                return const Center(child: Text("Failed to load the Profile"));
              }

              final offer = snapshot.data!;
              return Column(
                children: [
                  HeaderRow(text: 'Our Offers'),
                  // SizedBox(height: .h),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 24,
                      );
                    },
                    itemBuilder: (context, index) {
                      return DoctorsOffers(
                        doctorName: offer[index].user?.username ?? '',
                        doctorSpecialty:offer[index].specialty?.name??'' ,
                        price: offer[index].price??0,
                        offer:offer[index].offer??0 ,
                      );
                    },
                    itemCount: offer.length,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 35.h, bottom: 14),
                  ),
                ],
              );
            }));
  }
}
