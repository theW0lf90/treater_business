import 'package:flutter/material.dart';
import 'package:treater_business/calendar_screen.dart';
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
    //var businessData = context.watch<SignedBusiness>();
    var businessData = Provider.of<SignedBusiness>(context, listen: false);
    return Scaffold(
      body: Responsive(
        mobile: ReviewWrapper(companytype: businessData.comptype, linkedUid: businessData.linkedUid), // EmailScreen(),//CalendarScreen(),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: SideMenu(),
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
              child: ReviewWrapper(companytype: businessData.comptype, linkedUid: businessData.linkedUid),
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
