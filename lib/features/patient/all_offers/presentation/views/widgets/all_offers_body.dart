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
  List<Result> _offers = [];
  String? _next;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchInitialOffers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _next != null) {
        loadMoreOffers();
      }
    });
  }

  Future<void> fetchInitialOffers() async {
    setState(() => _isLoading = true);
    final response = await DoctorsApiService().fetchDoctors('has_offer=True');
    if (response != null) {
      setState(() {
        _offers = response.results ?? [];
        _next = response.next;
        _isLoading = false;
      });
    }
  }

  Future<void> loadMoreOffers() async {
    if (_next == null) return;
    setState(() => _isLoading = true);

    final uri = Uri.parse(_next!);
    final response = await DoctorsApiService().fetchDoctors(uri.query);
    if (response != null) {
      setState(() {
        _offers.addAll(response.results ?? []);
        _next = response.next;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
                children: [
                  HeaderRow(text: 'Our Offers'),
                  SizedBox(height:30.h),
                  Expanded(
                    child: _offers.isEmpty && _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                      controller: _scrollController,
                      itemCount: _offers.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        if (index < _offers.length) {
                          final doctor = _offers[index];
                          return DoctorsOffers(
                            doctorName: doctor.user?.username ?? '',
                            doctorSpecialty: doctor.specialty ?? '',
                            price: doctor.price ?? 0,
                            offer: doctor.offer ?? 0,
                            doctorId: doctor.id ?? 0,
                            photo: doctor.user?.image ?? '',
                          );
                        } else {
                          return _next != null
                              ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          )
                              : const SizedBox();
                        }
                      },
                      padding: EdgeInsets.only(bottom: 14.h, left: 16.w, right: 16.w),
                    ),
                  ),
                ],
        ),
    );
  }
@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}
}
