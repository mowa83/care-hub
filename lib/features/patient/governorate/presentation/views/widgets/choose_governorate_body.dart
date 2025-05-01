import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/constants/config.dart';
import 'package:graduation_project/core/constants/filters.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/patient/governorate/data/models/governorate_model.dart';
import 'package:graduation_project/features/patient/governorate/presentation/view%20model/governorate_api_service.dart';
import 'package:graduation_project/features/patient/city/presentation/views/choose_city_view.dart';
import 'package:graduation_project/core/shared_widgets/choose_list_view.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';

class ChooseGovernorateBody extends StatefulWidget {
  const ChooseGovernorateBody({super.key, this.specialty, required this.type});
  final String? specialty;
  final String type;

  @override
  State<ChooseGovernorateBody> createState() => _ChooseGovernorateBodyState();
}

class _ChooseGovernorateBodyState extends State<ChooseGovernorateBody> {
  // final ScrollController _scrollController = ScrollController();
  // final GovernorateApiService _apiService = GovernorateApiService();
  // final List<Result> _governorates = [];
  // String? _nextUrl = "$baseUrl/governorates/?limit=13&offset=0";
  // bool _isLoading = false;


  // @override
  // void initState() {
  //   super.initState();
  //   _fetchData();
  //
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels >=
  //             _scrollController.position.maxScrollExtent -350 &&
  //         !_isLoading &&
  //         _nextUrl != null) {
  //       _fetchData();
  //     }
  //   });
  // }
  //
  // Future<void> _fetchData() async {
  //   if (_nextUrl == null) return;
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final response = await _apiService.fetchGovernorates(_nextUrl!);
  //     if (response != null) {
  //       setState(() {
  //         _governorates.addAll(response.results ?? []);
  //         _nextUrl = response.next?.replaceFirst("127.0.0.1",ip);
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() => _isLoading = false);
  //     debugPrint("Error: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderRow(
            text: 'Choose governorate',
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
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: ChooseListView(
              // scrollController: _scrollController,
              items:governorates,
              // _governorates,
              onItemTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChooseCityView(
                          governorate: governorates[index],
                          specialty: widget.specialty,
                          type: widget.type,
                        )));
              },
              fontWeight: FontWeight.w400,
            ),
          ),
          // if (_isLoading)
          //   const Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: CircularProgressIndicator(),
          //   )
        ],
      ),
    );
  }
}
