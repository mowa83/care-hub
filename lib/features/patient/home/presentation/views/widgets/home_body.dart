import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/patient/all_offers/presentation/views/widgets/doctors_offers.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/our_offers_row.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/searchfor_doctor_stack.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/services_row.dart';
import 'package:graduation_project/features/patient/home/presentation/views/widgets/welcome_back_row.dart';

import '../../../../all_offers/data/models/offers_model.dart';
import '../../../../all_offers/presentation/view model/offers_api_service.dart';


class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeBackRow(),
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
                      return  DoctorsOffers(
                        doctorName: offer[index].user?.username ?? '',
                        doctorSpecialty:offer[index].specialty?.name??'' ,
                        price: offer[index].price??0,
                        offer:offer[index].offer??0 ,
                      );
                    },
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      );})
    );
  }
}
