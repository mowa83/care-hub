import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/custom_button.dart';
import 'package:graduation_project/core/themes/text_styles.dart';
import 'package:graduation_project/views/login/view.dart';
class UserTypeBody extends StatelessWidget {
  const UserTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    SizedBox sizedBox12=SizedBox(height: 12.h);
    return   Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child:  Column(
            children: [
              SizedBox(height: 88.h),
            Text('Select User Type',style: textStyle20(height: 1.5.h,letterSpacing: -.43)),
              SizedBox(height: 36.h),
              Image.asset('assets/images/doctor.png',height:131.h),
              sizedBox12,
              Text('Doctor',style: textStyle18(height: 1.5.h,letterSpacing: -.33),),
              SizedBox(height: 24.h),
              Image.asset('assets/images/nurse.png',height:131.h),
              sizedBox12,
              Text('Nurse',style: textStyle18(height: 1.5.h,letterSpacing: -.33),),
              SizedBox(height: 24.h),
              Image.asset('assets/images/patient.png',height:131.h),
              sizedBox12,
              Text('Patient',style: textStyle18(height: 1.5.h,letterSpacing: -.33),),
              SizedBox(height: 48.h),
              customButton(func: () => RouteUtils.pushAndRemoveAll(context, LoginView()), text: 'Next',lineHeight: 1.25),
              SizedBox(height: 37.h),
          ],),
        ),
      ),
    );
  }
}
