import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    CalendarFormat _calendarFormat = CalendarFormat.month;

    return Scaffold(body:
  //  Container(color: Colors.yellow,
    //    child: Center(child:Text(firebaseUser.email))),
      TableCalendar(
        firstDay: DateTime.utc(2021, 05,01),
        lastDay: DateTime.utc(2025, 05, 01),
        focusedDay: DateTime.now(),
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },

        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },

        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

        ),
    );
  }
}
