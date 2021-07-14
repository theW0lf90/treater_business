import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:treater_business/chart_data.dart';
import 'package:treater_business/company_model.dart';
import 'package:treater_business/company_queries.dart';
import 'package:treater_business/generalWidgets.dart';
import 'package:treater_business/imagePickerClass.dart';
import 'package:treater_business/review_model.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:treater_business/review_queries.dart';
import 'signedbusiness_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;


class DashboardWidgets extends StatefulWidget {
  final String uid;
  final String compType;
  const DashboardWidgets({Key key, this.uid, this.compType}) : super(key: key);

  @override
  _DashboardWidgetsState createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  double sum = 0;
  double avgScore = 0;
  String position = '';
  PickedFile imageFile;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CompanyQueries()
        .getCountryRank2(widget.compType, widget.uid)
        .then((value) {
      setState(() {
        position = '#$value af 3992';
      });
    });
    CompanyQueries().getIndustryReviewData(widget.compType);
  }


  @override
  Widget build(BuildContext context) {
    final businessData = context.watch<SignedBusiness>();
    final reviewList = context.watch<List<Review>>();

    print('hello from dashboard widgets ' + businessData.name);
    if (sum < 1) {
      reviewList.forEach((element) {
        print('im sum $sum');
        sum += element.revAgScore;
      });
    }
    if (sum > 0) {
      avgScore = sum / reviewList.length;
      print('im sum $avgScore');
    }

    var data = [
      new TreatmentAnalytics(treatmentName: 'Ryg', number: 5),
      new TreatmentAnalytics(treatmentName: 'Nakke', number: 10),
      new TreatmentAnalytics(treatmentName: 'Hofte', number: 3),
      new TreatmentAnalytics(treatmentName: 'Skulder', number: 7),
      new TreatmentAnalytics(treatmentName: 'Albuer', number: 6),
      new TreatmentAnalytics(treatmentName: 'Knæ', number: 1),
    ];

    var avgScoreData = [
      new TreatmentAnalyticsAverage(treatmentName: 'Ryg', score: 4.5),
      new TreatmentAnalyticsAverage(treatmentName: 'Hofte', score: 2.5),
      new TreatmentAnalyticsAverage(treatmentName: 'Skulder', score: 3.5),
      new TreatmentAnalyticsAverage(treatmentName: 'Albuer', score: 3.8),
      new TreatmentAnalyticsAverage(treatmentName: 'Knæ', score: 4.9),

    ];

    var series = [
      new charts.Series(
     //   colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault.lighter,
          fillColorFn: (_,__) => charts.MaterialPalette.red.shadeDefault.lighter,
          id: 'Antal',
          data: data,
          domainFn: (TreatmentAnalytics tretmentData, _) =>
              tretmentData.treatmentName,
          measureFn: (TreatmentAnalytics tretmentData, _) =>
              tretmentData.number),
    ];

    var avgRatingSeries = [
      new charts.Series(
          colorFn: (_,__) => charts.MaterialPalette.teal.shadeDefault.lighter,
          // fillColorFn: (_,__) => charts.MaterialPalette.purple.shadeDefault.lighter,
          id: 'Score',
          data: avgScoreData,
          domainFn: (TreatmentAnalyticsAverage tretmentData, _) =>
          tretmentData.treatmentName,
          measureFn: (TreatmentAnalyticsAverage tretmentData, _) =>
          tretmentData.score),
    ];


    var chart = new charts.BarChart(
      series,
      animate: true,
 //     vertical: true,
      defaultRenderer: new charts.BarRendererConfig(
        // By default, bar renderer will draw rounded bars with a constant
        // radius of 100.
        // To not have any rounded corners, use [NoCornerStrategy]
        // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(3)),
    );



    var avgScoreShart = new charts.BarChart(
      avgRatingSeries,
      animate: true,
      vertical: false,
      defaultRenderer: new charts.BarRendererConfig(
        // By default, bar renderer will draw rounded bars with a constant
        // radius of 100.
        // To not have any rounded corners, use [NoCornerStrategy]
        // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(3)),
    );

    var pieChart = new charts.PieChart(
      series,
      animate: true,
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));


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

    var avgScoreChartWidget = Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: avgScoreShart,
        ),
      ),
    );

    var pieWidget = Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: pieChart,
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
      backgroundColor: Theme.of(context).backgroundColor,
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
                          onPressed: () async {
                            //OPENS GALLERY and SELECTS IMAGE
                            // UPLOADS TO FIREBASE STORAGE
                            // UPDATES DOC with new URL
                            ImageHandler().openGallery(context,businessData);
                            },
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
                       padding: const EdgeInsets.all( 8.0),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        //mainAxisAlignment: MainAxisAlignment.,
                        children: [
                      gradientContainers(context, position, 'Placering', Icon(Icons.show_chart_outlined)),
                      gradientContainers(context, '$avgScore', 'Gns. vurdering', Icon(Icons.star_border_outlined)),
                      gradientContainers(context, reviewList.length.toString(), 'Anmeldelser', Icon(Icons.rate_review_outlined)),

                    ]),
                  ),
                ),
                buildHeader(context, 'Score for behandlingstyper'),
                avgScoreChartWidget,
                buildHeader(context, 'Fordeling'),
                chartWidget,
            //    pieWidget,



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

  Widget gradientContainers(
      BuildContext context, String unit, String header, Icon iconInput) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor, //.withOpacity(0.65),
            borderRadius: BorderRadius.circular(10),
        /*    gradient:  LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.tealAccent, Colors.lightBlue])),
           */
        ),

          child: Column(children: [

                Icon(iconInput.icon, color: Theme.of(context).primaryColor,size: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(header,
                  style: Theme.of(context).textTheme.headline3),
            ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Text(unit,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ),


          ]),

      ),
    );
  }
}
