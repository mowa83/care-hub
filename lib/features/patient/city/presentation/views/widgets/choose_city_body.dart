import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/patient/city/data/models/city_model.dart';
import 'package:graduation_project/features/patient/city/presentation/view%20model/city_api_service.dart';
import 'package:graduation_project/core/shared_widgets/choose_list_view.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';

class ChooseCityBody extends StatefulWidget {
  const ChooseCityBody({super.key, this.specialty, required this.governorate, required this.type});
  final int? specialty;
  final int governorate;
  final String type;

  @override
  State<ChooseCityBody> createState() => _ChooseCityBodyState();
}

class _ChooseCityBodyState extends State<ChooseCityBody> {
  final CityApiService _apiService = CityApiService();

  final List<Result> _cities = [];
  String? _nextUrl = "http://10.0.2.2:8000/api/cities/?limit=14&offset=0";
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_nextUrl == null) return;
    try {
      while (_nextUrl != null) {
        final response = await _apiService.fetchcities(_nextUrl!);
        if (response != null) {
          setState(() {
            _cities.addAll(response.results ?? []);
            _nextUrl = response.next?.replaceFirst("127.0.0.1", "10.0.2.2");
          });
        } else {
          _nextUrl = null;
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cities.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    List<Result> filteredCities = _cities
        .where((city) => city.governorate!.id == widget.governorate)
        .toList();
    return Scaffold(
      body: Column(
        children: [
          const HeaderRow(
            text: 'Choose City',
          ),
          SizedBox(
            height: 35.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose Your Location",
                  style: textStyle18(
                      fontSize: 16.sp, height: 1.5, letterSpacing: .1),
                ),
                SvgPicture.asset('assets/icons/location.svg')
              ],
            ),
          ),
          SizedBox(height: 24.h,),
          Expanded(
            child: ChooseListView(
              items: filteredCities,
              onItemTap: (index) {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ChooseCityView(
                //       governorate: governorate,
                //       specialty: specialty,
                //     )));
              },
              fontWeight:FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
