import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/themes/colors.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/screens/doctor/signup/signup_doctor_nurse_screen.dart';
import 'package:graduation_project/screens/patient/signup/chronic_diseases_screen.dart';

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
              HeaderRow(text: 'Select User Type'),
              // SizedBox(height: 88.h),
              // Text('Select User Type',
              //     style: textStyle20(height: 1.5.h, letterSpacing: -.43)),
              SizedBox(height: 36.h),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUserType = 'Doctor'; 
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
                                color: AppColor.primarycolor,
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a user type.'),
                        ),
                      );
                    } else {
                      if (selectedUserType == 'Doctor' ||
                          selectedUserType == 'Nurse') {
                        RouteUtils.pushAndRemoveAll(
                          context,
                          SignupDoctorNurseScreen(userType: selectedUserType!),
                        );
                      } else if (selectedUserType == 'Patient') {
                        RouteUtils.pushAndRemoveAll(
                            context,  ChronicDiseasesScreen());
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
