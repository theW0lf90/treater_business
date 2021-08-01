import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:treater_business/booking_model.dart';
import 'package:treater_business/daily_bookings_screen.dart';
import 'package:treater_business/daily_bookings_wrapper.dart';
import 'package:treater_business/generalWidgets.dart';
import 'package:treater_business/signedbusiness_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  String dailyIdentifier;
   List<BookingModel> displayBookingList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
    dailyIdentifier=  _selectedDay.year.toString() + '_' + _selectedDay.month.toString() + '_' + _selectedDay.day.toString();

  }

  uploadTimeSlots(int month) {
    var date = DateTime(2021,month);
    // Take the input year, month number, and pass it inside DateTime()
    int daysInMonth = DateTimeRange(
        start: date,
        end: DateTime(date.year, date.month + 1))
        .duration
        .inDays;

    print('input from page changed ' + daysInMonth.toString());

    for(int dayCounter = 1; dayCounter <= 1; dayCounter++){
   //   print('NEW RUN OF BOOKINGQUERYIES');
      BookingQueries().createBookingCalendar(date.year, month, dayCounter, 0);

 //     print('For Loop Called $dayCounter Times');

    }

  }

  @override

  Widget build(BuildContext context) {
    final businessUser = context.watch<SignedBusiness>();
    final bookingList = context.watch<List<BookingModel>>();
    print('setting state $dailyIdentifier');


      if(displayBookingList.length <2) {
        displayBookingList = bookingList.where((element) => element.dailyIdentifier == dailyIdentifier).toList();
      }
      displayBookingList.sort((a, b) => a.dailyTimeIndex.compareTo(b.dailyTimeIndex));

    print('hello from calendarscreen ' + bookingList.length.toString()); // + businessUser.uid);

    CalendarFormat _calendarFormat = CalendarFormat.month;

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    /*  floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          uploadTimeSlots(8);
        },
        label: Text('upload timeslots'),

      ),*/
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GenericContainer(
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
todayDecoration: BoxDecoration(
  shape: BoxShape.circle,
  color: Theme.of(context).primaryColor.withOpacity(0.8),
),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      )
                  ),

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
                      _focusedDay = focusedDay;

                      dailyIdentifier=  _selectedDay.year.toString() + '_' + _selectedDay.month.toString() + '_' + _selectedDay.day.toString();
                       print('daily identifier $dailyIdentifier');

                    displayBookingList = bookingList.where((element) => element.dailyIdentifier == dailyIdentifier).toList();


                    });
                  },

                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;

                    });
                  },

                  onPageChanged: (focusedDay) async {
                    _focusedDay = focusedDay;
                    print('page changed ' + _focusedDay.toString());
                       //   await uploadTimeSlots(focusedDay.month);
                  },
                  ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GenericContainer(
                child: SizedBox(
                    height: 500,
                    child: DailyBookingsScreen(displayDailyBookingList: displayBookingList, dailyIndex: _selectedDay.day,
                    )) //DailyBookingWrapper(dailyIdentifier: dailyIdentifier)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
