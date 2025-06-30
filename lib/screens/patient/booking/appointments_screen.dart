import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/booking/appointments_edit_screen.dart';
import 'package:graduation_project/screens/patient/booking/services/appointment/appointment_model.dart';
import 'package:graduation_project/screens/patient/booking/services/appointment/appointment_services.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:intl/intl.dart';

class AppointementsScreen extends StatefulWidget {
  const AppointementsScreen({super.key});

  @override
  _AppointementsScreenState createState() => _AppointementsScreenState();
}

class _AppointementsScreenState extends State<AppointementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<AppointmentModel>> _pastAppointmentsFuture;
  late Future<List<AppointmentModel>> _upcomingAppointmentsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pastAppointmentsFuture = AppointmentService().fetchPastAppointments();
    _upcomingAppointmentsFuture =
        AppointmentService().fetchUpcomingAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _groupAppointments(
      List<AppointmentModel> appointments, bool isPast) {
    final Map<String, List<AppointmentModel>> grouped = {};
    final now = DateTime.now();
    final dateFormatter =
        DateFormat('d MMM, yyyy', 'en_US'); 

    for (var appointment in appointments) {
      final dateStr = appointment.date ?? '';
      if (dateStr.isEmpty) continue;

      try {
        final appointmentDate = DateTime.parse(dateStr);
        final formattedDate = dateFormatter.format(appointmentDate);
        _getDayLabel(appointmentDate, now);

        grouped.putIfAbsent(formattedDate, () => []).add(appointment);
      } catch (e) {
        debugPrint('Error parsing date $dateStr: $e');
        continue;
      }
    }

    return grouped.entries.map((entry) {
      DateTime? entryDate;
      try {
        entryDate = dateFormatter.parse(entry.key);
      } catch (e) {
        debugPrint('Error parsing grouped date ${entry.key}: $e');
        entryDate = DateTime.now();
      }

      return {
        'date': entry.key,
        'day': _getDayLabel(entryDate, now),
        'originalDate': entryDate, 
        'appointments': entry.value.map((appointment) {
          final time = appointment.time ?? '';
          String formattedTime = '';
          try {
            final parsedTime = DateFormat('HH:mm:ss').parse(time);
            formattedTime = DateFormat('h:mm a').format(parsedTime);
          } catch (e) {
            debugPrint('Error parsing time $time: $e');
            formattedTime = time;
          }
          return {
            'id': appointment.id, 
            'doctor': appointment.doctor?.doctorName ?? 'Unknown',
            'doctorId': appointment.doctor?.id, 
            'time': formattedTime,
            'status': isPast ? 'Done' : 'Edit',
            'specialty': appointment.doctor?.specialty ?? 'Unknown',
            'image': appointment.doctor?.image,
          };
        }).toList(),
      };
    }).toList()
      ..sort((a, b) => (a['originalDate'] as DateTime)
          .compareTo(b['originalDate'] as DateTime));
  }

  String _getDayLabel(DateTime appointmentDate, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDay = DateTime(
        appointmentDate.year, appointmentDate.month, appointmentDate.day);
    final difference = appointmentDay.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';
    return DateFormat('EEEE').format(appointmentDate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Padding(
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
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FutureBuilder<List<AppointmentModel>>(
                      future: _pastAppointmentsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const Center(
                              child: Text('Failed to load past appointments'));
                        }
                        final appointments =
                            _groupAppointments(snapshot.data!, true);
                        return _buildAppointmentList(appointments);
                      },
                    ),
                    FutureBuilder<List<AppointmentModel>>(
                      future: _upcomingAppointmentsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const Center(
                              child:
                                  Text('Failed to load upcoming appointments'));
                        }
                        final appointments =
                            _groupAppointments(snapshot.data!, false);
                        return _buildAppointmentList(appointments);
                      },
                    ),
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
    if (appointments.isEmpty) {
      return const Center(child: Text('No appointments found'));
    }
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
                    appointment['image'] != null &&
                            appointment['image'].isNotEmpty
                        ? CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(appointment['image']),
                            onBackgroundImageError: (_, __) =>
                                const Icon(Icons.error),
                          )
                        : const CircleAvatar(
                            radius: 30,
                            child: Image(
                                image: AssetImage('assets/images/image1.png')),
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
                                          fontSize: 14,
                                        )
                                      ],
                                    )
                                  : AppText(
                                      onTap: () {
                                        RouteUtils.push(
                                          context,
                                          AppointmentsEditScreen(
                                            appointmentId: appointment['id'],
                                            doctorId: appointment['doctorId'],
                                          ),
                                        );
                                      },
                                      title: 'Edit',
                                      color: AppColors.primary,
                                      decorationColor: AppColors.primary,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                            ],
                          ),
                          Text(
                            appointment['specialty'],
                            style: const TextStyle(color: Colors.grey),
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
                              'At ${appointment['time']}',
                              style: const TextStyle(fontSize: 14),
                            ),
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
