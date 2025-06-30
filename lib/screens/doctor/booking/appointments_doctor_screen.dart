import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/doctor/booking/services/doctor_appointment/appointment_doctor_model.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:intl/intl.dart';
import 'services/doctor_appointment/appointment_doctor_services.dart';

class AppointmentsDoctorScreen extends StatefulWidget {
  const AppointmentsDoctorScreen({super.key});

  @override
  _AppointmentsDoctorScreenState createState() =>
      _AppointmentsDoctorScreenState();
}

class _AppointmentsDoctorScreenState extends State<AppointmentsDoctorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _pastAppointments = [];
  List<Map<String, dynamic>> _upcomingAppointments = [];
  bool _isLoading = true;
  String? _errorMessage;
  final AppointmentService _appointmentService = AppointmentService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _appointmentService.dispose();
    super.dispose();
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty || time == 'N/A') return 'N/A';
    try {
      final dateFormat = DateFormat('HH:mm');
      final parsedTime = dateFormat.parse(time);
      final amPmFormat = DateFormat('h:mm a');
      return amPmFormat.format(parsedTime);
    } catch (e) {
      return time;
    }
  }

  Future<void> _fetchAppointments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final pastAppointments =
          await _appointmentService.fetchPastAppointments();
      final upcomingAppointments =
          await _appointmentService.fetchUpcomingAppointments();

      setState(() {
        _pastAppointments = _groupAppointmentsByDate(pastAppointments);
        _upcomingAppointments = _groupAppointmentsByDate(upcomingAppointments);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load appointments: $e';
      });
    }
  }

  List<Map<String, dynamic>> _groupAppointmentsByDate(
      List<AppointmentDoctorModel> appointments) {
    final validAppointments = appointments
        .where((a) => a.date != null && _isValidDate(a.date!))
        .toList();

    final Map<String, List<AppointmentDoctorModel>> grouped = {};
    for (var appointment in validAppointments) {
      grouped.putIfAbsent(appointment.date!, () => []).add(appointment);
    }

    return grouped.entries.map((entry) {
      final date = entry.key;
      final appointments = entry.value;
      final day = _getDayLabel(date);
      return {
        'date': date,
        'day': day,
        'appointments': appointments
            .map((a) => {
                  'patientName': a.patientName ?? 'Unknown',
                  'time': a.time ?? 'N/A',
                  'phoneNumber': a.phoneNumber ?? 'N/A',
                  'status':
                      a.date == DateTime.now().toIso8601String().split('T')[0]
                          ? 'Edit'
                          : 'Done',
                })
            .toList(),
      };
    }).toList()
      ..sort((a, b) {
        try {
          final dateA = DateTime.parse(a['date'] as String);
          final dateB = DateTime.parse(b['date'] as String);
          return dateA.compareTo(dateB);
        } catch (e) {
          return (a['date'] as String).compareTo(b['date'] as String);
        }
      });
  }

  bool _isValidDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  String _getDayLabel(String date) {
    try {
      final today = DateTime.now();
      final appointmentDate = DateTime.parse(date);
      final difference = appointmentDate.difference(today).inDays;
      if (difference == 0) return 'Today';
      if (difference == 1) return 'Tomorrow';
      if (difference == -1) return 'Yesterday';
      return date;
    } catch (e) {
      return date;
    }
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
              const SizedBox(height: 16),
              Center(
                child: AppText(
                  title: 'My Appointments',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 36),
              Container(
                height: 48,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 250, 248),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.primary,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w500),
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Past'),
                    Tab(text: 'Upcoming'),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(28),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text(_errorMessage!))
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              _buildAppointmentList(_pastAppointments,
                                  isUpcoming: false),
                              _buildAppointmentList(_upcomingAppointments,
                                  isUpcoming: true),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList(List<Map<String, dynamic>> appointments,
      {required bool isUpcoming}) {
    if (appointments.isEmpty) {
      return const Center(child: Text('No appointments available'));
    }
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final section = appointments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${section['date']}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...section['appointments'].map<Widget>((appointment) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child:
                          Image(image: AssetImage('assets/images/image1.png')),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                title: appointment['patientName'],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              (!isUpcoming && appointment['status'] == 'Done')
                                  ? const Row(
                                      children: [
                                        AppText(
                                          title: '• Done',
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    )
                                  : AppText(
                                      title: '',
                                      color: AppColors.primary,
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.call_outlined,
                                color: AppColors.primary,
                                size: 15,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                appointment['phoneNumber'],
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 228, 250, 248),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'At ${_formatTime(appointment['time'])}',
                                style: const TextStyle(fontSize: 14),
                              ))
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
