import 'package:flutter/material.dart';
import 'package:treater_business/calendarWrapper.dart';
import 'package:treater_business/calendar_screen.dart';
import 'package:treater_business/dashboard.dart';
import 'package:treater_business/dashboard_widgets.dart';
import 'package:treater_business/dashboard_wrapper.dart';
import 'package:treater_business/emails_list.dart';
import 'package:treater_business/responsive.dart';
import 'package:treater_business/review_wrapper.dart';
import 'package:treater_business/sidemenu.dart';
import 'package:treater_business/signedbusiness_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var businessData = context.watch<SignedBusiness>();
    print('hello from mainscreen wrapper' + businessData.comptype + businessData.linkedUid);

    return Scaffold(
      body: Responsive(
        mobile: CalendarWrapper(),//DashboardWrapper(),//companytype: businessData.comptype,linkedUid: businessData.linkedUid ),//ReviewWrapper(companytype: businessData.comptype, linkedUid: businessData.linkedUid), // EmailScreen(),//CalendarScreen(),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: ReviewWrapper(),//companytype: businessData.comptype, linkedUid: businessData.linkedUid),//SideMenu(),
            ),
            Expanded(
              flex: 9,
              child: DashboardWrapper(),//companytype: businessData.comptype,linkedUid: businessData.linkedUid ),//CalendarScreen(),
            )
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: size.width > 1340 ? 4 : 5,
              child: DashboardWrapper()//,companytype: businessData.comptype,linkedUid: businessData.linkedUid ),//SideMenu(),
            ),
            Expanded(
              flex: size.width > 1340 ? 4 : 5,
              child:  ReviewWrapper(),//companytype: businessData.comptype, linkedUid: businessData.linkedUid),
            ),
            Expanded(
              flex: size.width > 1340? 4 : 5,
              child: CalendarWrapper(),
            ),

          ],
        ),
      ),
    );
  }
}
