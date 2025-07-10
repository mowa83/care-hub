import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/manage_dialog.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_model.dart';
import 'package:graduation_project/screens/doctor/booking/services/add_slots/add_slots_services.dart';
import 'package:graduation_project/screens/doctor/booking/update_appointment_screen.dart';
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
  bool _isAddingSlot = false;

  final AddSlotsServices _addSlotsServices = AddSlotsServices();
  Future<List<AvailableSlots>> _slotsFuture =
      AddSlotsServices().fetchAvailableSlots();

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
    _selectedDay = _focusedDay;
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

      await _addSlotsServices.addSlots(slotData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Slot added successfully')),
      );

      setState(() {
        _slotsFuture = _addSlotsServices.fetchAvailableSlots();
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

        final slots = snapshot.data ?? [];

        final List<String> availableTimeSlotsForSelectedDay = slots
            .where((slot) {
              if (slot.date == null || _selectedDay == null) return false;
              final slotDate = DateTime.parse(slot.date!);
              return isSameDay(slotDate, _selectedDay!);
            })
            .map((slot) => _convertTo12Hour(slot.time!))
            .toList();

        return Scaffold(
          body: SingleChildScrollView(
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
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _selectedTime = null;
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        if (_hasAvailableSlots(day, slots)) {
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                                availableTimeSlotsForSelectedDay.contains(time);
                            final isSelected =
                                _selectedTime == time && !isAvailable;

                            return GestureDetector(
                              onTap: () {
                                if (isAvailable) {
                                  final slot = slots.firstWhere(
                                    (slot) =>
                                        slot.date != null &&
                                        isSameDay(DateTime.parse(slot.date!),
                                            _selectedDay!) &&
                                        _convertTo12Hour(slot.time!) == time,
                                    orElse: () => AvailableSlots(),
                                  );
                                  if (slot.id != null) {
                                    showManageSlotDialog(
                                      context: context,
                                      onEdit: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateAppointmentScreen(
                                              slot: slot,
                                              onUpdate: () {
                                                setState(() {
                                                  _slotsFuture =
                                                      _addSlotsServices
                                                          .fetchAvailableSlots();
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      onDelete: () async {
                                        try {
                                          await _addSlotsServices
                                              .cancelSlot(slot.id!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Slot deleted successfully'),
                                            ),
                                          );
                                          setState(() {
                                            _slotsFuture = _addSlotsServices
                                                .fetchAvailableSlots();
                                          });
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                            ),
                                          );
                                        }
                                      },
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
                            !_isAddingSlot &&
                            !availableTimeSlotsForSelectedDay
                                .contains(_selectedTime)
                        ? _addSlot
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26A69A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isAddingSlot
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Confirm',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
