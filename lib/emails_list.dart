import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:treater_business/TextfieldDialog.dart';
import 'package:treater_business/review_model.dart';
import 'package:provider/provider.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    navigateToAnswer(Review review, String businessUid) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TextFieldDialog(review: review, businessUid: businessUid)),
      );
    }


    final businessUser = context.watch<User>();
    final reviewList = context.watch<List<Review>>();

    return Scaffold(

      appBar: AppBar(
        title:
            Text('Anmeldelser', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body:
            ListView.builder(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: reviewList.length,
            itemBuilder: (_, int index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, right: 8, bottom: 10),
                          child: CircleAvatar(
                            maxRadius: 14,
                            backgroundColor: Colors.blue,
                            //DetailFunctions().setAvatarColor(index),
                            child: Text(
                              reviewList[index].revUsername != null &&
                                      !reviewList[index].revUsername.isEmpty
                                  ? reviewList[index].revUsername[0]
                                  : '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Flexible(
                          child: Text(
                            reviewList[index].revTypeTitle,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          reviewList[index].revDate,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 5,
                        size: 20,
                        isReadOnly: true,
                        color: Colors.amber,
                        borderColor: Colors.amber,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        rating: reviewList[index].revAgScore,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 10, right: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reviewList[index].revText,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    addResponseLayout(reviewList[index], context),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: Theme.of(context).cardColor.withOpacity(0.65),
                            foregroundColor: Theme.of(context).primaryColor,
                            label: reviewList[index].hasAnswer
                                ? Text('Rediger')
                                : Text('Besvar'),
                            icon: reviewList[index].hasAnswer
                                ? Icon(Icons.edit)
                                : Icon(Icons.add),
                            elevation: 0,
                            onPressed: () async {
                              print('im tapped');
                              navigateToAnswer(
                                  reviewList[index], businessUser.uid);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget addResponseLayout(Review review, BuildContext context) {
    if (!review.hasAnswer) {
      return SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16, left: 16.0, right: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                maxRadius: 14,
                backgroundColor: Colors.deepOrange,
                //DetailFunctions().setAvatarColor(index),
                child:// imgURL == ''?
                Text(
                  review.compName[0],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
             //   ): Text('t') //Image.network(imgURL, fit: BoxFit.contain)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  review.compName,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              Text(
                review.revResponseDate,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 35, top: 8, right: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).backgroundColor.withOpacity(0.65),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 12, bottom: 12),
                child: Text(
                  review.reviewAnswer,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ]),
      );
    }
  }
  // Future<Widget> buildProfileImg(String imgURL) async {
  //   if(imgURL.length < 3 || imgURL == null) {
  //     return Text('Upload billed');
  //   } else {
  //     return Image.network(imgURL, fit: BoxFit.cover);
  //   }
  // }
}
