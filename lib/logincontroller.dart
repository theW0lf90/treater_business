import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:treater_business/continuewithemail_screen.dart';

class LoginController extends StatefulWidget {
  const LoginController({Key key}) : super(key: key);

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  navigateToAccountScreens(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => index == 0 ? ContinueWithEmailScreen(isSignUp: false) : ContinueWithEmailScreen(isSignUp: true),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Velkommen',
          style:Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 40.0),
          child: Container(
            decoration: BoxDecoration(color:Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
            height: double.infinity,
            //color: Colors.black,

            child: SingleChildScrollView(
              //padding:
              //  const EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 80.0),
              child: Column(

                  children: [
                    Container(constraints: BoxConstraints(
                        minWidth: kIsWeb? 500: 200, maxWidth: 800, minHeight: kIsWeb ? 400: 150, maxHeight: 800),
                        child: Image.asset('assets/background.jpg')),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
                          child: SignInButtonBuilder(
                            height: kIsWeb ? 45 : 40,
                            width: kIsWeb ? 300 : 200,
                            backgroundColor:Theme.of(context).primaryColor,
                            text: 'Fortsæt med email',
                            icon: Icons.email_outlined,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
                            onPressed: () {
                              var index = 0;
                              navigateToAccountScreens(index);

                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: kIsWeb ? 35: 25.0),
                          child: SignInButtonBuilder(
                            height: kIsWeb ? 45 : 40,
                            width: kIsWeb ? 300 : 200,

                            backgroundColor: Colors.black,
                            text: 'Opret konto', textColor: Colors.white,
                            icon: Icons.account_circle_outlined,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
                            onPressed: () {
                              var index = 1;
                              navigateToAccountScreens(index);

                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: kIsWeb ? 25: 15.0),
                          child: FlatButton(
                            onPressed: () {
                           //TODO   navigateToResetScreen();
                            },
                            child: Text(
                              'Glemt password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ]),
            ),
          ),
        ),
      ),
    );
  }

}
