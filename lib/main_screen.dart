import 'package:flutter/material.dart';
import 'package:treater_business/calendar_screen.dart';
import 'package:treater_business/emails_list.dart';
import 'package:treater_business/responsive.dart';
import 'package:treater_business/sidemenu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        mobile: CalendarScreen(),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: EmailScreen(),
            ),
            Expanded(
              flex: 9,
              child: CalendarScreen(),
            )
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: size.width > 1340 ? 2 : 4,
              child: SideMenu(),
            ),
            Expanded(
              flex: size.width > 1340 ? 3 : 5,
              child: EmailScreen(),
            ),
            Expanded(
              flex: size.width > 1340? 8 : 10,
              child: CalendarScreen(),
            ),

          ],
        ),
      ),
    );
  }
}
