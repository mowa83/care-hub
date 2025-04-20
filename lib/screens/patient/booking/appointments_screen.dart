import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/booking/appointments_edit_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';

class AppointementsScreen extends StatefulWidget {
  const AppointementsScreen({super.key});

  @override
  _AppointementsScreenState createState() => _AppointementsScreenState();
}

class _AppointementsScreenState extends State<AppointementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _pastAppointments = [
    {
      'date': '2 Oct, 2023',
      'day': 'Today',
      'appointments': [
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Done'
        },
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Done'
        },
      ],
    },
    {
      'date': '3 Oct, 2023',
      'day': 'Tomorrow',
      'appointments': [
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Done'
        },
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Done'
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'date': '2 Oct, 2023',
      'day': 'Today',
      'appointments': [
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Edit'
        },
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Edit'
        },
      ],
    },
    {
      'date': '3 Oct, 2023',
      'day': 'Tomorrow',
      'appointments': [
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Edit'
        },
        {
          'doctor': 'Dr. Ahmed Yasser',
          'time': '9:00 - 10:00 AM',
          'status': 'Edit'
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Image(image: AssetImage('assets/images/profile-circle.png')),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: 'Welcome Back',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      AppText(
                        title: 'Mr. Ahmed',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(100),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.primary,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  tabs: const [
                    Tab(text: 'Past'),
                    Tab(text: 'Upcoming'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAppointmentList(_pastAppointments),
                    _buildAppointmentList(_upcomingAppointments),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList(List<Map<String, dynamic>> appointments) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final section = appointments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${section['day']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${section['date']}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...section['appointments'].map<Widget>((appointment) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                        radius: 30,
                        child: Image(
                            image: AssetImage('assets/images/image1.png'))),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                title: appointment['doctor'],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              appointment['status'] == 'Done'
                                  ? const Row(
                                      children: [
                                        AppText(
                                          title: '• Done',
                                          color: AppColors.primary,
                                        )
                                      ],
                                    )
                                  : AppText(
                                      onTap: () {
                                        RouteUtils.push(context,
                                            AppointmentsEditScreen());
                                      },
                                      title: 'Edit',
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline,
                                    )
                            ],
                          ),
                          const Text(
                            'Dentist',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'At ${appointment['time']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
