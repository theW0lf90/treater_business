import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:treater_business/custom_alert.dart';
import 'package:treater_business/review_model.dart';
import 'package:treater_business/review_queries.dart';

class TextFieldDialog extends StatefulWidget {
  const TextFieldDialog({Key key, this.review, this.businessUid})
      : super(key: key);

  final Review review;
  final String businessUid;

  @override
  _TextFieldDialogState createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _textEditingController.text = widget.review.reviewAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
  insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
      backgroundColor: Theme.of(context).backgroundColor,
      child:
      SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 8, right: 8, bottom: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10),
                      child: Text('Anmeldelse', style: Theme.of(context).textTheme.headline2),
                    ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, top: 8, right: 8, bottom: 10),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        //DetailFunctions().setAvatarColor(index),
                        child: Text(
                          widget.review.revUsername != null &&
                                  !widget.review.revUsername.isEmpty
                              ? widget.review.revUsername[0]
                              : '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(
                      child: Text(
                        widget.review.revTypeTitle,
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      widget.review.revDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 65.0),
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
                    rating: widget.review.revAgScore,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 70, top: 10, right: 10, bottom: 10),
                  child: Text(
                    widget.review.revText,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Divider(),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 25, left: 16),
                    //   child: Text('Besvarelse', style: Theme.of(context).textTheme.headline2),
                    // ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                   //   crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(

                                maxLength: null,
                                maxLines: null,
                                autofocus: false,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).cardColor,
                                  hintText: 'Skriv din besvarelse',
                                  hintStyle: Theme.of(context).textTheme.subtitle1,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Theme.of(context).cardColor)),
                                  focusedBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.red),
                            ),
                                ),
                                controller: _textEditingController,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, right: 10, left: 10, bottom: 25),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      child:
                                     Icon(Icons.clear, color: Colors.red,),
                                      onTap: () async {
                                        setState(() {
                                          _textEditingController.text = '';
                                        });
                                        //  setReview(userProvider);
                                      }),

                                  InkWell(
                                    child: Icon(Icons.send_outlined, color: Theme.of(context).primaryColor),

                                    onTap: () async {
                                      print('im tapped');
                                      if(!widget.review.revId.isEmpty && !_textEditingController.text.isEmpty && !widget.businessUid.isEmpty )
                                    ReviewQueries().respondToReview(widget.review, _textEditingController.text, widget.businessUid);
                                    },
                                  ),
                                ])),
                      ],
                    ),
                  ),
                ),
              ]),
              //Invisible container to dismiss textfield
              //   Expanded(child: Container(color:Theme.of(context).backgroundColor))
         //   ),
          ),
        ),
        ),
      ),
    );
  }
}
