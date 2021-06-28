
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:treater_business/custom_alert.dart';
import 'package:treater_business/main.dart';


class ContinueWithEmailScreen extends StatefulWidget {
  final bool isSignUp;
  ContinueWithEmailScreen({Key key, this.isSignUp}) : super(key: key);

  @override
  _ContinueWithEmailScreenState createState() =>
      _ContinueWithEmailScreenState();
}

class _ContinueWithEmailScreenState extends State<ContinueWithEmailScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _passWordTextEditingController =
  TextEditingController();

  TextEditingController _confirmPassWordTextEditingController =
  TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _passWordTextEditingController.dispose();
    _confirmPassWordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email Login',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),

              child: SingleChildScrollView(
                padding:
                const EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 80.0),
                child: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            minWidth: kIsWeb? 400: 200, maxWidth: 500, minHeight: kIsWeb ? 300: 150, maxHeight: kIsWeb ? 800: 200),
                        child: Image.asset(widget.isSignUp? 'assets/create_acc.png' : 'assets/sign_in.png')),

                    Padding(padding: EdgeInsets.symmetric(vertical:16), child: widget.isSignUp ?   Text('Opret konto', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)) : Text('Login med email',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    Container(
                      constraints: BoxConstraints(
                          minWidth: kIsWeb? 500: 200, maxWidth: 800, minHeight: kIsWeb ? 70 : 40, maxHeight: 200),
                      child: Padding(
                          padding:
                          const EdgeInsets.only(top: 20, left: 12, right: 12.0),
                          child: buildTextFormField('Email', _textEditingController, false)),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minWidth: kIsWeb? 500: 200, maxWidth: 800, minHeight: kIsWeb ? 70 : 40, maxHeight: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 12, right: 12.0),
                        child: buildTextFormField(
                            'Password', _passWordTextEditingController, true),
                      ),
                    ),
                    widget.isSignUp
                        ? Container(
                      constraints: BoxConstraints(
                          minWidth: kIsWeb? 500: 200, maxWidth: 800, minHeight: kIsWeb ? 70 : 40, maxHeight: 200),
                      child: Padding(
                          padding:
                          const EdgeInsets.only(top: 20, left: 12, right: 12.0),
                          child: buildTextFormField('Bekræft password',
                              _confirmPassWordTextEditingController, true)),
                    )
                        : Padding(padding: EdgeInsets.all(1)),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: FloatingActionButton.extended(

                        onPressed: () async {
                          try {
                            User user = widget.isSignUp
                                ? (await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _textEditingController.text,
                              password:
                              _confirmPassWordTextEditingController.text,
                            )

                            )
                                .user

                                : (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: _textEditingController.text,
                              password: _passWordTextEditingController.text,
                            ))
                                .user;
                            if (user != null) {
                              //TO-DO
                              writeMetaData(user);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthenticationWrapper()),
                              );
                            }
                          } catch (e) {
                            print(e);
                            _textEditingController.text = "";
                            _passWordTextEditingController.text = "";
                            _confirmPassWordTextEditingController.text = "";

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                      title: 'Noget gik galt', message: e.toString());
                                });
                          }
                        },
                        label: Text(widget.isSignUp ? 'Opret konto' : 'Login'),
                        icon: Icon(Icons.check),
                        backgroundColor:Theme.of(context).primaryColor,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  writeMetaData(User user) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference metaData = _firestore.collection('DK').doc('UsersDoc').collection('Users').doc(user.uid).collection('Metadata');

    metaData.doc(user.uid).get()
        .then((DocumentSnapshot documentSnapshot) {

      if (documentSnapshot.exists) {
        print('Doc exists');
      } else {
        print('is first time user');
        metaData.doc(user.uid)
            .set({
          'email': user.email,
          'joined': Timestamp.now(),
          'numbReviews': 0,
          'username': user.email,
        });
      }
    });
  }


  TextFormField buildTextFormField(
      String hintText, TextEditingController controller, bool isPassword) {
    return TextFormField(
      maxLines: 1,
      autofocus: false,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: isPassword? true: false,
      decoration: InputDecoration(
        filled: true,
        fillColor:Theme.of(context).backgroundColor,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle1,
        enabledBorder: UnderlineInputBorder(
          borderSide: new BorderSide(color: Theme.of(context).cardColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.teal[300]),
        ),
      ),
      controller: controller,
    );
  }
}
