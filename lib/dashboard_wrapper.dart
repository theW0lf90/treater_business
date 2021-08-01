import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:treater_business/dashboard_widgets.dart';
import 'package:treater_business/emails_list.dart';
import 'package:treater_business/review_model.dart';
import 'package:treater_business/review_queries.dart';
import 'package:treater_business/signedbusiness_model.dart';
import 'package:treater_business/tabbar_mobile.dart';
import 'package:treater_business/responsive.dart';

class DashboardWrapper extends StatelessWidget {
  DashboardWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var businessData = context.watch<SignedBusiness>();
    print('hello from dashboard wrapper' + businessData.comptype + businessData.linkedUid);

    return FutureProvider<List<Review>>(
      child: DashboardWidgets(compType: businessData.comptype ,uid: businessData.linkedUid),
      initialData: [],
      create: (_) => ReviewQueries().getReviewList(businessData.comptype, businessData.linkedUid),
      // catchError: (_, Error) => Error.toString(),
    );
  }
}
