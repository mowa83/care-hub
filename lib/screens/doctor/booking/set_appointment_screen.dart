import 'package:flutter/material.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_model.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'update_appointment_screen.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';

class SetAppointmentScreen extends StatefulWidget {
  const SetAppointmentScreen({super.key});

  @override
  _SetAppointmentScreenState createState() => _SetAppointmentScreenState();
}

class _SetAppointmentScreenState extends State<SetAppointmentScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  List<AvailableSlots> _availableSlots = [];
  List<String> _availableTimeSlots = [];
  bool _isAddingSlot = false;
  final AddSlotsServices _addSlotsServices = AddSlotsServices();
  Future<List<AvailableSlots>> _slotsFuture =
      AddSlotsServices().fetchAvailableSlots();
  final List<String> _timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  Future<List<AvailableSlots>> _fetchAvailableSlots() async {
    return await _addSlotsServices.fetchAvailableSlots();
  }

  void _updateAvailableTimeSlots(List<AvailableSlots> slots) {
    _availableSlots = slots;
    _availableTimeSlots = slots
        .where((slot) {
          if (slot.date == null || _selectedDay == null) return false;
          final slotDate = DateTime.parse(slot.date!);
          return isSameDay(slotDate, _selectedDay!);
        })
        .map((slot) => _convertTo12Hour(slot.time!))
        .toList();
  }

  String _convertTo12Hour(String time) {
    final DateTime parsedTime = DateFormat('HH:mm').parse(time);
    return DateFormat('hh:mm a').format(parsedTime);
  }

  String _convertTo24Hour(String time) {
    final DateTime parsedTime = DateFormat('hh:mm a').parse(time);
    return DateFormat('HH:mm').format(parsedTime);
  }

  Future<void> _addSlot() async {
    if (_selectedDay == null || _selectedTime == null) return;
    if (_availableTimeSlots.contains(_selectedTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This time slot is already added')),
      );
      return;
    }
    setState(() {
      _isAddingSlot = true;
    });
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay!);
      final formattedTime = _convertTo24Hour(_selectedTime!);
      final slotData = [
        {
          'date': formattedDate,
          'times': [formattedTime]
        }
      ];
      final result = await _addSlotsServices.addSlots(slotData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Appointment added for $formattedDate at $_selectedTime (${result.message})',
          ),
        ),
      );
      setState(() {
        _slotsFuture = _fetchAvailableSlots();
        _selectedTime = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding slot: $e')),
      );
    } finally {
      setState(() {
        _isAddingSlot = false;
      });
    }
  }

  bool _hasAvailableSlots(DateTime day, List<AvailableSlots> slots) {
    return slots.any((slot) {
      if (slot.date == null) return false;
      final slotDate = DateTime.parse(slot.date!);
      return isSameDay(slotDate, day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AvailableSlots>>(
      future: _slotsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        _updateAvailableTimeSlots(snapshot.data ?? []);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  Center(
                    child: AppText(
                      title: 'Set Appointment',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 36),
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
                          _updateAvailableTimeSlots(snapshot.data ?? []);
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          if (_hasAvailableSlots(day, snapshot.data ?? [])) {
                            return Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 217, 217, 217),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style: const TextStyle(color: Colors.black),
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
                        titleTextStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                  SizedBox(
                    height: 200,
                    child: _isAddingSlot
                        ? const Center(child: CircularProgressIndicator())
                        : _timeSlots.isEmpty
                            ? const Center(
                                child: Text('No time slots available'))
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 3,
                                ),
                                itemCount: _timeSlots.length,
                                itemBuilder: (context, index) {
                                  final time = _timeSlots[index];
                                  final isAvailable =
                                      _availableTimeSlots.contains(time);
                                  final isSelected =
                                      _selectedTime == time && !isAvailable;
                                  return GestureDetector(
                                    onTap: () {
                                      if (isAvailable) {
                                        final slot = _availableSlots.firstWhere(
                                          (slot) =>
                                              slot.date != null &&
                                              isSameDay(
                                                  DateTime.parse(slot.date!),
                                                  _selectedDay!) &&
                                              _convertTo12Hour(slot.time!) ==
                                                  time,
                                          orElse: () => AvailableSlots(),
                                        );
                                        if (slot.id != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateAppointmentScreen(
                                                slot: slot,
                                                onUpdate: () {
                                                  setState(() {
                                                    _slotsFuture =
                                                        _fetchAvailableSlots();
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _selectedTime = time;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF26A69A)),
                                        borderRadius: BorderRadius.circular(20),
                                        color: isAvailable
                                            ? AppColors.primary
                                            : isSelected
                                                ? AppColors.grey
                                                : AppColors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          time,
                                          style: TextStyle(
                                            color: isAvailable || isSelected
                                                ? AppColors.white
                                                : AppColors.primary,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedDay != null &&
                              _selectedTime != null &&
                              !_isAddingSlot
                          ? _addSlot
                          : null,
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
