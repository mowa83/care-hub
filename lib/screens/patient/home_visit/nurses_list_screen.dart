import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurses_list_service.dart';
import 'package:graduation_project/screens/patient/home_visit/widgets/app_nurse_card.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurses_list_model.dart';

class NursesListScreen extends StatefulWidget {
  const NursesListScreen({
    super.key,
    required this.governorate,
    required this.city,
  });
  final String governorate;
  final String city;
  @override
  State<NursesListScreen> createState() => _NursesListScreenState();
}

class _NursesListScreenState extends State<NursesListScreen> {
  List<Result> _nurses = [];
  String? _next;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchInitialNurses();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _next != null) {
        loadMoreNurses();
      }
    });
  }

  Future<void> fetchInitialNurses() async {
    setState(() => _isLoading = true);
    final response = await NursesListService().fetchNurses(
        'city=${widget.city}&city__governorate=${widget.governorate}');
    if (response != null) {
      setState(() {
        _nurses = response.results ?? [];
        _next = response.next;
        _isLoading = false;
      });
    }
  }

  Future<void> loadMoreNurses() async {
    if (_next == null) return;
    setState(() => _isLoading = true);

    final uri = Uri.parse(_next!);
    final response = await NursesListService().fetchNurses(uri.query);
    if (response != null) {
      setState(() {
        _nurses.addAll(response.results ?? []);
        _next = response.next;
        _isLoading = false;
      });
    }
  }

  // late final Future<List<Result>?> nursesFuture;
  // @override
  // void initState() {
  //   super.initState();
  //   nursesFuture = NursesListService().fetchNurses(
  //       'city=${widget.city}&city__governorate=${widget.governorate}');
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // FutureBuilder<List<Result>?>(
            //   future: nursesFuture,
            //   builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: CircularProgressIndicator());
            // } else if (snapshot.hasError || snapshot.data == null) {
            //   return const Center(child: Text("Failed to load nurses"));
            // }
            //
            // final nurses = snapshot.data!;
            // return
            Column(
      children: [
        HeaderRow(
          text: '${widget.governorate}| ${widget.city}',
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: _nurses.isEmpty && _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  controller: _scrollController,
                  itemCount: _nurses.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _nurses.length) {
                      final nurse = _nurses[index];
                      return AppNurseCard(
                        label: nurse.user ?? '',
                        description: nurse.about ?? '',
                        photo: nurse.image ?? '',
                        nurseId: nurse.id!,
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
        // Expanded(
        //   child: ListView.separated(
        //     itemBuilder: (context, index) {
        //       return AppNurseCard(
        //           label: nurses[index].user??'',
        //           description:nurses[index].about??'',
        //           photo:nurses[index].image??'',
        //       nurseId: nurses[index].id!,);
        //     },
        //     separatorBuilder: (context, index) {
        //       return SizedBox(height: 5.h);
        //     },
        //     itemCount: nurses.length,
        //     padding: EdgeInsets.only(bottom: 16.h,left:16.w,right: 16.w ),
        //   ),
        // )
      ],
    ));
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
