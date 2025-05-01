import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/chat/chat_room_screen.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurse_model.dart';
import 'package:graduation_project/screens/patient/home_visit/services/nurse_service.dart';
import 'package:graduation_project/widgets/app_text.dart';

class NurseScreen extends StatefulWidget {
  const NurseScreen({super.key, required this.nurseId});
  final int nurseId;
  @override
  State<NurseScreen> createState() => _NurseScreenState();
}

class _NurseScreenState extends State<NurseScreen> {
  late final Future<NurseModel?> nurseFuture;
  @override
  void initState() {
    super.initState();
    nurseFuture =
        NurseService().fetchNurse(widget.nurseId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<NurseModel?>(
        future: nurseFuture,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError || snapshot.data == null) {
        return const Center(child: Text("Failed to load"));
      }

      final nurse = snapshot.data!;
      return Stack(
        children: [
          Column(
            children: [
              HeaderRow(
                text: 'Nurse Details',
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  children:  [
                    Center(
                      child: Column(
                        children: [
                          nurse.user?.image != null &&
                              nurse.user!.image!.isNotEmpty
                              ? CircleAvatar(
                            radius: 40.r,
                            backgroundColor: AppColor.secondryColor,
                            child: ClipOval(
                              child: Image.network(
                                nurse.user!.image!,
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                            ),
                          )
                              : Icon(Icons.error),
                          SizedBox(height: 8),
                          AppText(
                            title: nurse.user?.username??'',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    AppText(
                      title: "Phone Number",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/call.png')),
                        SizedBox(width: 8),
                        AppText(
                          title: nurse.user?.phoneNumber??'',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    AppText(
                      title: "About Me",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4),
                    AppText(
                      title: nurse.about??'',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: 20),
                    AppText(
                      title: "Services",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8),
                    AppText(
                      title: nurse.services??'',
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      height: 85,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            left: 16,
            right: 16,
            child: InkWell(
              onTap: () {
                RouteUtils.push(context, ChatRoomScreen());
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(image: AssetImage('assets/images/Group.png')),
                    SizedBox(
                      width: 8,
                    ),
                    AppText(
                      title: 'Chat',
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );})
    );
  }
}
