import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/models/doctor_profile_model.dart';
import 'package:graduation_project/screens/patient/booking/booking_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

import '../../../core/services/doctor_profile_api_service.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen(
      {super.key, required this.doctorId, required this.specialty});
  final int doctorId;
  final String specialty;

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late final Future<DoctorProfileModel?> doctorFuture;
  @override
  void initState() {
    super.initState();
    doctorFuture =
        ApiService().fetchProfileModel('/doctor/${widget.doctorId}/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DoctorProfileModel?>(
          future: doctorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text("Failed to load"));
            }

            final doctor = snapshot.data!;
            return Stack(
              children: [
                Column(children: [
                  const HeaderRow(
                    text: 'Doctor Details',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              doctor.user?.image != null &&
                                      doctor.user!.image!.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 40.r,
                                      backgroundColor: AppColor.secondryColor,
                                      child: ClipOval(
                                        child: Image.network(
                                          doctor.user!.image!,
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
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: doctor.user?.username ?? '',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Divider(
                                      height: 12.h,
                                      color: Colors.grey[350],
                                    ),
                                    AppText(
                                      title: widget.specialty,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.primarycolor,
                                    child: SvgPicture.asset(
                                      'assets/icons/chats.svg',
                                      colorFilter: ColorFilter.mode(
                                          Colors.white, BlendMode.srcIn),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'Chat Doctor',
                                    style: textStyle12(
                                        fontSize: 10.sp, letterSpacing: 0),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/Group 15.png'),
                                  ),
                                  AppText(
                                    title: doctor.offer == null
                                        ? '${doctor.price}EGP'
                                        : '${doctor.offer}EGP',
                                    color: AppColors.primary,
                                  ),
                                  AppText(title: 'Price'),
                                ],
                              ),
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/Group 15 (1).png'),
                                  ),
                                  AppText(
                                    title: '${doctor.experienceYear}+',
                                    color: AppColors.primary,
                                  ),
                                  AppText(title: 'Years Exper..'),
                                ],
                              ),
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/Group 15 (2).png'),
                                  ),
                                  AppText(
                                    title: doctor.user?.phoneNumber ?? '',
                                    color: AppColors.primary,
                                  ),
                                  AppText(title: 'Phone Number'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          AppText(
                            title: 'About Me',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            doctor.about ?? '',
                            style: textStyle12(
                                color: Color(0xff787B80),
                                fontSize: 14.sp,
                                height: 1.7,
                                letterSpacing: .5),
                          ),
                          SizedBox(height: 27.h),
                          AppText(
                            title: 'Certificates',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            doctor.certificates ?? '',
                            style: textStyle12(
                                color: Color(0xff787B80),
                                fontSize: 16.sp,
                                letterSpacing: .1),
                          ),
                          const SizedBox(
                            height: 70,
                          ),

                        ],
                      ),
                    ),
                  ),

                ]),
                Positioned(
                  bottom: 10,
                  left: 16,
                  right: 16,
                  child: InkWell(
                    onTap: () {
                      RouteUtils.push(context, BookingScreen());
                    },
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AppText(
                            title: 'Book Appointement',
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
            );
          }),
    );
  }
}
