import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treater_business/chart_data.dart';
import 'package:treater_business/company_model.dart';
import 'package:treater_business/company_queries.dart';
import 'package:treater_business/review_model.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:treater_business/review_queries.dart';

import 'signedbusiness_model.dart';

class DashboardWidgets extends StatefulWidget {
  final String uid;

  const DashboardWidgets({Key key, this.uid}) : super(key: key);

  @override
  _DashboardWidgetsState createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  double sum = 0;
  double avgScore = 0;
  String position = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CompanyQueries()
        .getCountryRank2('Physiotherapist', widget.uid)
        .then((value) {
      setState(() {
        position = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final businessData = context.watch<SignedBusiness>();
    final reviewList = context.watch<List<Review>>();

    print(businessData.name);
    if (sum < 1) {
      reviewList.forEach((element) {
        sum += element.revAgScore;
      });
    }
    if (sum > 0) {
      avgScore = sum / reviewList.length;
    }

    var data = [
      new TreatmentAnalytics(treatmentName: 'Ryg', number: 5),
      new TreatmentAnalytics(treatmentName: 'Nakke', number: 10),
      new TreatmentAnalytics(treatmentName: 'Hofte', number: 3),
      new TreatmentAnalytics(treatmentName: 'Skulder', number: 7),
      new TreatmentAnalytics(treatmentName: 'Albuer', number: 6),
      new TreatmentAnalytics(treatmentName: 'Knæ', number: 1),
    ];

    var series = [
      new charts.Series(
          id: 'Antal',
          data: data,
          domainFn: (TreatmentAnalytics tretmentData, _) =>
              tretmentData.treatmentName,
          measureFn: (TreatmentAnalytics tretmentData, _) =>
              tretmentData.number),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: chart,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text('Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildHeader(context, 'Profil'),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 8, bottom: 20, right: 8),
                  child: Container(
                    height: 150,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(businessData.imgURL)),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.extended(
                          backgroundColor:
                              Theme.of(context).backgroundColor.withOpacity(0.0),
                          foregroundColor: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            //      side: BorderSide(color: Theme.of(context).primaryColor)
                          ),
                          onPressed: () {},
                          label: Text('Rediger'),
                          icon: Icon(Icons.photo_camera_outlined)),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context, 'Services'),
              FloatingActionButton.extended(
          backgroundColor:
          Theme.of(context).backgroundColor.withOpacity(0.0),
            foregroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //      side: BorderSide(color: Theme.of(context).primaryColor)
            ),
            onPressed: () {},
            label: Text('Tilføj '),
            icon: Icon(Icons.add)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 5,
                    children: [
                      for (var k in businessData.services) servicesLabel(k.toString()),
                    ],
                  ),
                ),

                buildHeader(context, 'Statistik'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    gradientContainers(context, position, 'Placering'),
                    gradientContainers(context, '$avgScore', 'Gns. vurdering'),
                    gradientContainers(context, reviewList.length.toString(), 'Anmeldelser'),

                  ]),
                ),
                chartWidget
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget servicesLabel(String service) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 5, bottom: 8),
      child: Container(
        //constraints: BoxConstraints(
        //     minWidth: 40, maxWidth: 125, maxHeight: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.blue[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: service.isEmpty ? SizedBox.shrink() : Text(service,
              style: TextStyle(fontStyle: FontStyle.italic)),
        ),
      ),
    );
  }

  Padding buildHeader(BuildContext context, String title) {
    return Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 8),
              child: Text(title,
                  style: Theme.of(context).textTheme.headline1),
            );
  }

  Container gradientContainers(
      BuildContext context, String unit, String header) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.65),
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent, Colors.deepPurpleAccent])),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(unit,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          //Theme.of(context).textTheme.headline1),
          Text(header,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.8)))
          //style: Theme.of(context).textTheme.bodyText2),
        ]),
      ),
    );
  }
}
