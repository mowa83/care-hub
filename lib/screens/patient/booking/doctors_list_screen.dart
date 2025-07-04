import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/booking/widgets/app_doctor_card.dart';
import '../../../core/models/doctors_model.dart';
import '../../../core/services/doctors_api_service.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({
    super.key,
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
  List<Result> _doctors = [];
  String? _next;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchInitialDoctors();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _next != null) {
        loadMoreDoctors();
      }
    });
  }

  Future<void> fetchInitialDoctors() async {
    setState(() => _isLoading = true);
    final response = await DoctorsApiService().fetchDoctors(
        'city=${widget.city}&city__governorate=${widget.governorate}&specialty=${widget.specialty}');
    if (response != null) {
      setState(() {
        _doctors = response.results ?? [];
        _next = response.next;
        _isLoading = false;
      });
    }
  }

  Future<void> loadMoreDoctors() async {
    if (_next == null) return;
    setState(() => _isLoading = true);

    final uri = Uri.parse(_next!);
    final response = await DoctorsApiService().fetchDoctors(uri.query);
    if (response != null) {
      setState(() {
        _doctors.addAll(response.results ?? []);
        _next = response.next;
        _isLoading = false;
      });
    }
  }

  // late final Future<DoctorsModel?> doctorsFuture;
  // @override
  // void initState() {
  //   super.initState();
  //   doctorsFuture = DoctorsApiService().fetchDoctors(
  //       'city=${widget.city}&city__governorate=${widget.governorate}&specialty=${widget.specialty}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // FutureBuilder<DoctorsModel?>(
            //     future: doctorsFuture,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError || snapshot.data == null) {
            //         return const Center(child: Text("Failed to load doctors"));
            //       }
            //
            //       final doctors = snapshot.data!;
            //       return
            Column(
      children: [
        HeaderRow(
          text: '${widget.governorate}| ${widget.city}',
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: _doctors.isEmpty && _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  controller: _scrollController,
                  itemCount: _doctors.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _doctors.length) {
                      final doctor = _doctors[index];
                      return AppDoctorCard(
                        label: doctor.user?.username ?? '',
                        description: doctor.specialty ?? '',
                        photo: doctor.user?.image ?? '',
                        price: doctor.price ?? 0,
                        offer: doctor.offer,
                        doctorId: doctor.id ?? 8,
                        specialty: doctor.specialty ?? '',
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
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5.h);
                  },
                  padding:
                      EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                ),
        ),
      ],
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
