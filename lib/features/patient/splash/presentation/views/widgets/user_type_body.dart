import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/features/doctor/profile/presentation/views/profile_view.dart' as doctor;
import 'package:graduation_project/features/nurse/profile/presentation/views/profile_view.dart'as nurse;
import 'package:graduation_project/features/patient/profile/presentation/views/profile_view.dart'as patient;



class UserTypeBody extends StatefulWidget {
  const UserTypeBody({super.key});

  @override
  State<UserTypeBody> createState() => _UserTypeBodyState();
}

class _UserTypeBodyState extends State<UserTypeBody> {
  String? selectedUserType;
  @override
  Widget build(BuildContext context) {
    SizedBox sizedBox12 = SizedBox(height: 12.h);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 88.h),
              Text('Select User Type',
                  style: textStyle20(height: 1.5.h, letterSpacing: -.43)),
              SizedBox(height: 36.h),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUserType = 'Doctor'; // Update selected user type
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: selectedUserType == 'Doctor'
                            ? Border.all(
                                color: AppColor.primarycolor,
                                width: 3) // Add border if selected
                            : null,
                      ),
                      child: Image.asset(
                        'assets/images/doctor.png',
                        height: 131.h,
                      ))),
              sizedBox12,
              Text(
                'Doctor',
                style: textStyle18(height: 1.5.h, letterSpacing: -.33),
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUserType = 'Nurse'; // Update selected user type
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: selectedUserType == 'Nurse'
                            ? Border.all(
                                color: AppColor.primarycolor,
                                width: 3) // Add border if selected
                            : null,
                      ),
                      child: Image.asset('assets/images/nurse.png',
                          height: 131.h))),
              sizedBox12,
              Text(
                'Nurse',
                style: textStyle18(height: 1.5.h, letterSpacing: -.33),
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUserType = 'Patient'; // Update selected user type
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: selectedUserType == 'Patient'
                            ? Border.all(
                                color:AppColor.primarycolor,
                                width: 3) // Add border if selected
                            : null,
                      ),
                      child: Image.asset('assets/images/patient.png',
                          height: 131.h))),
              sizedBox12,
              Text(
                'Patient',
                style: textStyle18(height: 1.5.h, letterSpacing: -.33),
              ),
              SizedBox(height: 48.h),
              customButton(
                  func: () {
                    if (selectedUserType == null) {
                      // Show an error if no user type is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a user type.'),
                        ),
                      );
                    } else {
                      switch (selectedUserType) {
                        case 'Doctor':
                          RouteUtils.pushAndRemoveAll(context, doctor.ProfileView());
                          break;
                        case 'Nurse':
                          RouteUtils.pushAndRemoveAll(context, nurse.ProfileView());
                          break;
                        case 'Patient':
                          RouteUtils.pushAndRemoveAll(context, patient.ProfileView());
                          break;
                      }
                    }
                  },
                  text: 'Next',
                  lineHeight: 1.25),
              SizedBox(height: 37.h),
            ],
          ),
        ),
      ),
    );
  }
}

