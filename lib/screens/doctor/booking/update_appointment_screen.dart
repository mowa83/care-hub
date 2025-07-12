import 'package:flutter/material.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_model.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';

class UpdateAppointmentScreen extends StatefulWidget {
  final AvailableSlots slot;
  final VoidCallback onUpdate;

  const UpdateAppointmentScreen({
    super.key,
    required this.slot,
    required this.onUpdate,
  });

  @override
  _UpdateAppointmentScreenState createState() =>
      _UpdateAppointmentScreenState();
}

class _UpdateAppointmentScreenState extends State<UpdateAppointmentScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  List<String> _availableTimeSlots = [];
  bool _isUpdatingSlot = false;
  final AddSlotsServices _addSlotsServices = AddSlotsServices();
  late final Future<List<AvailableSlots>> _slotsFuture;

  final List<String> _timeSlots = [
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 AM',
  ];

  @override
  void initState() {
    super.initState();
    _slotsFuture = _addSlotsServices.fetchAvailableSlots();

    final slotDate = DateTime.parse(widget.slot.date!);
    final today = DateTime.now();
    _selectedDay =
        slotDate.isBefore(DateTime(today.year, today.month, today.day))
            ? DateTime(today.year, today.month, today.day)
            : slotDate;
    _selectedTime = _convertTo12Hour(widget.slot.time!);
  }

  void _updateAvailableTimeSlots(List<AvailableSlots> slots) {
    _availableTimeSlots = slots
        .where((slot) {
          if (slot.date == null || _selectedDay == null) return false;
          if (slot.id == widget.slot.id) return false;
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

  Future<void> _updateSlot() async {
    if (_selectedDay == null || _selectedTime == null) return;
    if (_availableTimeSlots.contains(_selectedTime) &&
        !(_selectedDay == DateTime.parse(widget.slot.date!) &&
            _selectedTime == _convertTo12Hour(widget.slot.time!))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This time slot is already added')),
      );
      return;
    }
    setState(() {
      _isUpdatingSlot = true;
    });
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay!);
      final formattedTime = _convertTo24Hour(_selectedTime!);
      final slotData = {
        'date': formattedDate,
        'time': formattedTime,
        'doctor_name': widget.slot.doctorName,
        'specialty': widget.slot.specialty,
      };
      await _addSlotsServices.updateSlot(widget.slot.id!, slotData);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Slot updated successfully'),
        ),
      );
      widget.onUpdate();
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating slot: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isUpdatingSlot = false;
      });
    }
  }

  bool _hasAvailableSlots(DateTime day, List<AvailableSlots> slots) {
    return slots.any((slot) {
      if (slot.date == null) return false;
      if (slot.id == widget.slot.id) return false;
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
                  const HeaderRow(
                    text: 'Update Appointment',
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
                    child: _isUpdatingSlot
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
                                  final isBooked =
                                      _availableTimeSlots.contains(time);
                                  final isSelected =
                                      _selectedTime == time && !isBooked;
                                  return GestureDetector(
                                    onTap: isBooked
                                        ? null
                                        : () {
                                            setState(() {
                                              _selectedTime = time;
                                            });
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF26A69A)),
                                        borderRadius: BorderRadius.circular(20),
                                        color: isBooked
                                            ? Colors.grey
                                            : isSelected
                                                ? AppColors.primary
                                                : Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          time,
                                          style: TextStyle(
                                            color: isBooked
                                                ? Colors.white
                                                : isSelected
                                                    ? Colors.white
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
                              !_isUpdatingSlot
                          ? _updateSlot
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF26A69A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Update',
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
