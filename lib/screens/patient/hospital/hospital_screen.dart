import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/hospital/widgets/app_department_card.dart';
import 'package:graduation_project/widgets/app_text.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          HeaderRow(
            text: 'Hospital Details',
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                Image(image: AssetImage('assets/images/Frame 1261154967.png')),
          ),
          SizedBox(height: 12),
          Center(
            child: AppText(
                title: 'Mansoura Hospital',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(image: AssetImage('assets/images/location.png')),
              SizedBox(width: 5),
              AppText(
                  title: 'Mansoura Qism 2, El Mansoura 1, Dakahlia',
                  fontSize: 14,
                  color: AppColors.black),
            ],
          ),
          SizedBox(height: 15),
          AppText(
              title: 'Hospital Department',
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: 8),
          AppDepartmentCard(
              departmentName: 'Department Surgical',
              workingHours: '08:00 - 20:00 PM'),
          Divider(color: Colors.grey[300], thickness: 1, height: 20),
          SizedBox(
            height: 15,
          ),
          AppDepartmentCard(
              departmentName: 'Department Surgical',
              workingHours: '09:00 - 22:00 PM'),
          Divider(color: Colors.grey[300], thickness: 1, height: 20),
          SizedBox(
            height: 15,
          ),
          AppDepartmentCard(
              departmentName: 'Department Surgical',
              workingHours: '04:00 - 22:00 PM'),
          Divider(color: Colors.grey[300], thickness: 1, height: 20),
          SizedBox(
            height: 15,
          ),
          AppDepartmentCard(
              departmentName: 'Department Surgical',
              workingHours: '08:00 - 20:00 PM'),
        ],
      ),
    );
  }
}

