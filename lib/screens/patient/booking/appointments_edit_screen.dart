import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/booking/appointments_screen.dart';
import 'package:graduation_project/screens/patient/booking/services/booking/booking_models.dart';
import 'package:graduation_project/screens/patient/booking/services/booking/booking_services.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AppointmentsEditScreen extends StatefulWidget {
  const AppointmentsEditScreen({
    super.key,
    required this.appointmentId,
    required this.doctorId,
  });

  final int appointmentId;
  final int doctorId;

  @override
  _AppointmentsEditScreenState createState() => _AppointmentsEditScreenState();
}

class _AppointmentsEditScreenState extends State<AppointmentsEditScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  late Future<List<AvailableSlotModel>> _availableSlotsFuture;
  List<AvailableSlotModel> _availableSlots = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _availableSlotsFuture = _fetchInitialSlots();
  }

  Future<List<AvailableSlotModel>> _fetchInitialSlots() async {
    final slots = await BookingService().fetchAvailableSlots(widget.doctorId, DateTime.now());
    setState(() {
      _availableSlots = slots; 
    });
    return slots;
  }

  void _fetchAvailableSlots() {
    setState(() {
      _availableSlotsFuture = BookingService()
          .fetchAvailableSlots(widget.doctorId, _selectedDay ?? DateTime.now())
          .then((slots) {
        setState(() {
          _availableSlots = slots;
        });
        return slots;
      });
    });
  }

  List<String> _getAvailableTimesForSelectedDay() {
    if (_selectedDay == null) return [];
    final selectedDateStr = DateFormat('yyyy-MM-dd').format(_selectedDay!);
    return _availableSlots
        .where((slot) => slot.date == selectedDateStr)
        .map((slot) =>
            DateFormat('hh:mm a').format(DateTime.parse('2025-01-01 ${slot.time}')))
        .toList();
  }

  bool _hasAvailableSlots(DateTime day) {
    final dateStr = DateFormat('yyyy-MM-dd').format(day);
    return _availableSlots.any((slot) => slot.date == dateStr);
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
              const HeaderRow(
                text: 'Edit Appointment',
              ),
              const SizedBox(height: 20),
              AppText(
                title: 'Select Date',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2025, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedTime = null; 
                      _fetchAvailableSlots();
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      if (_hasAvailableSlots(day) && !isSameDay(day, _selectedDay)) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      return null; 
                    },
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(color: Colors.black),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    leftChevronIcon:
                        Icon(Icons.arrow_back_ios, color: Colors.black),
                    rightChevronIcon:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AppText(
                title: 'Select Time',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<List<AvailableSlotModel>>(
                  future: _availableSlotsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: Text('Failed to load time slots'));
                    }

                    final availableTimes = _getAvailableTimesForSelectedDay();

                    if (availableTimes.isEmpty) {
                      return const Center(child: Text('No available time slots'));
                    }

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3,
                      ),
                      itemCount: availableTimes.length,
                      itemBuilder: (context, index) {
                        final time = availableTimes[index];
                        final isSelected = _selectedTime == time;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTime = time;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF26A69A)),
                              borderRadius: BorderRadius.circular(20),
                              color: isSelected ? AppColors.primary : AppColors.white,
                            ),
                            child: Center(
                              child: Text(
                                time,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedDay != null && _selectedTime != null) {
                      try {
                        final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDay!);
                        final timeStr = DateFormat('HH:mm:ss').format(
                            DateFormat('hh:mm a').parse(_selectedTime!));
                        final appointment = BookAppointmentModel(
                          doctor: widget.doctorId,
                          date: dateStr,
                          time: timeStr,
                        );
                        await BookingService().updateAppointment(
                          widget.appointmentId,
                          appointment,
                        );
                        RouteUtils.push(context, const AppointementsScreen());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Appointment updated for ${DateFormat('dd/MM/yyyy').format(_selectedDay!)} at $_selectedTime',
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update appointment: $e')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select date and time')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26A69A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}