import 'package:flutter/material.dart';
import 'package:treater_business/calendar_screen.dart';
import 'package:treater_business/emails_list.dart';
import 'package:treater_business/sidemenu.dart';

class TabbarMobile extends StatefulWidget {
  const TabbarMobile({Key key}) : super(key: key);

  @override
  _TabbarMobileState createState() => _TabbarMobileState();
}

class _TabbarMobileState extends State<TabbarMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,

          appBar: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: 'Anmeldelser', icon: Icon(Icons.rate_review_outlined)),
                Tab(text: 'Bookings', icon: Icon(Icons.calendar_today_outlined)),
          //      Tab(text: 'Favoritter', icon: Icon(Icons.favorite)),
                Tab(text: 'Profil', icon: Icon(Icons.menu_outlined))
              ]),

          // title: Text('Treater', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24)),

          body: TabBarView(children: [
            EmailScreen(),
            CalendarScreen(),
            SideMenu()

          ]),
        ),
      ),
    );
  }
}
