
import 'package:flutter/material.dart';
import 'package:treater_business/review_model.dart';
import 'package:provider/provider.dart';

class DashboardWidgets extends StatelessWidget {
  const DashboardWidgets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final reviewList = context.watch<List<Review>>();
    double sum = 0;
    reviewList.forEach((element) { sum += element.revAgScore; });
    final avgScore = sum / reviewList.length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        gradientContainers(context, reviewList.length.toString(), 'Anmeldelser'),
        gradientContainers(context, '$avgScore', 'Gns. vurdering'),
        gradientContainers(context, '5', 'Bookinger'),
      ]),
    );
  }

  Container gradientContainers(BuildContext context, String unit, String header) {
    return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.65),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin:Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurpleAccent.withOpacity(0.6),
              Colors.purpleAccent]
        )
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text(unit, style: Theme.of(context).textTheme.headline1),
        Text(header, style: Theme.of(context).textTheme.bodyText2),
      ]),
    ),

  );
  }
}