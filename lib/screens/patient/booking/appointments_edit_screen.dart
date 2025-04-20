import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/booking/appointments_screen.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsEditScreen extends StatefulWidget {
  const AppointmentsEditScreen({super.key});

  @override
  _AppointmentsEditScreenState createState() => _AppointmentsEditScreenState();
}

class _AppointmentsEditScreenState extends State<AppointmentsEditScreen> {
  DateTime _focusedDay = DateTime(2025, 2, 1);
  DateTime? _selectedDay;
  String? _selectedTime;

  final List<String> _timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '15:00 PM',
    '15:30 PM',
    '16:00 PM',
    '16:30 PM',
    '17:00 PM',
    '17:30 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(2021, 2, 17);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderRow(
              text: 'Nurse Details',
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              title: 'Select Date',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TableCalendar(
                firstDay: DateTime(2025, 1, 1),
                lastDay: DateTime(2025, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
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
              title: 'Select Date',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3,
                ),
                itemCount: _timeSlots.length,
                itemBuilder: (context, index) {
                  final time = _timeSlots[index];
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
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDay != null && _selectedTime != null) {
                    RouteUtils.push(context, AppointementsScreen());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Appointment booked for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year} at $_selectedTime',
                        ),
                      ),
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
    );
  }
}
