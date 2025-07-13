import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/models/patient_profile_model.dart';
import 'package:graduation_project/screens/chat/chat_room_screen.dart';
import 'package:graduation_project/screens/chat/services/chat_services.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:intl/intl.dart';
import '../../../core/services/patient_profile_api_service.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key, required this.patientId});
  final int patientId;
  @override
  State<PatientScreen> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<PatientScreen> {
  late final Future<PatientProfileModel?> userFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userFuture = ApiService().fetchProfile("${widget.patientId}/Patient/");
  }

  // ${widget.patientId}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PatientProfileModel?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Failed to load the Profile"));
          }

          final profile = snapshot.data!;
          List<Map<String, dynamic>> profileItems = [
            {
              'icon': 'assets/icons/profile.svg',
              'text': profile.user?.username ?? 'Name',
            },
            {
              'icon': 'assets/icons/calendar.svg',
              'text': profile.user?.birthDate != null
                  ? DateFormat('yyyy-MM-dd').format(profile.user!.birthDate!)
                  : 'Birth Date',
            },
            {
              'icon': 'assets/icons/call.svg',
              'text': profile.user?.phoneNumber ?? 'Phone Number',
            },
            {
              'icon': 'assets/icons/female.svg',
              'text': profile.user?.gender ?? 'Gender',
            },
          ];
          return Stack(children: [
            Column(
              children: [
                HeaderRow(
                  text: 'Patient Details',
                ),
                // SizedBox(height: 200,),
                Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    children: [
                      SvgPicture.asset(
                        'assets/icons/profile-circle.svg',
                        width: 97.w,
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            width: 343.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: const Color(0xffEBEBEB))),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 11.w, right: 8.w),
                                  child: SvgPicture.asset(
                                    profileItems[index]['icon']!,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xff292D32), BlendMode.srcIn),
                                  ),
                                ),
                                Text(profileItems[index]['text']!,
                                    style: textStyle12(
                                        fontSize: 16, height: 1.375))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 12.h,
                          );
                        },
                        itemCount: profileItems.length,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Chronic Diseases',
                            style: textStyle12(fontSize: 14.sp),
                          )),
                      Container(
                        // alignment: Alignment.center,
                        width: 343.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 11.w, vertical: 13.h),
                        margin: EdgeInsets.only(bottom: 28.h, top: 12.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xffEBEBEB))),
                        child: Text(
                          profile.chronicDiseases ??
                              'No chronic diseases specified',
                          style: textStyle12(height: 1.75),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70.h,
                ),
              ],
            ),         Positioned(
                bottom: 12,
                left: 16,
                right: 16,
                child: InkWell(
                  onTap: () async {
                    try {
                      final chatService = ChatService();
                      final chatData = await chatService.startChat(widget.patientId);
                      RouteUtils.push(
                        context,
                        ChatRoomScreen(
                          chatId: chatData['chatId'],
                          targetId: chatData['targetId'],
                          targetName: chatData['targetName'],
                          targetImage: chatData['targetImage'],
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to start chat: $e')),
                      );
                    }
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
              ),
          ],
          );
        },
      ),
    );
  }
}
