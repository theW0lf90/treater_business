import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:treater_business/dashboard_widgets.dart';
import 'package:treater_business/emails_list.dart';
import 'package:treater_business/review_model.dart';
import 'package:treater_business/review_queries.dart';
import 'package:treater_business/signedbusiness_model.dart';
import 'package:treater_business/tabbar_mobile.dart';
import 'package:treater_business/responsive.dart';

class ReviewWrapper extends StatelessWidget {
  ReviewWrapper({Key key,this.companytype, this.linkedUid}) : super(key: key);
  //final compID;
  final String companytype;
  final String linkedUid;

  @override
  Widget build(BuildContext context) {
    //final List<Review> reviews = [];
 //   var firebaseUser = context.watch<SignedBusiness>();

    return StreamProvider<List<Review>>(
      child: DashboardWidgets(uid: linkedUid),//EmailScreen(), // Responsive.isMobile(context)? TabbarMobile() : EmailScreen(),
        initialData: [],
        create: (_) => ReviewQueries().streamReviewList(companytype, linkedUid),
        // catchError: (_, Error) => Error.toString(),
      );
  }
}
