import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:treater_business/authentication_service.dart';
import 'package:treater_business/company_queries.dart';
import 'package:treater_business/dashboard.dart';
import 'package:treater_business/logincontroller.dart';
import 'package:treater_business/main_screen.dart';
import 'package:treater_business/main_screen_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
          context.read<AuthenticationService>().authStateChanges,
        ),

      ],
      child: MaterialApp(
        title: 'Treater',
        theme: ThemeData(
          backgroundColor: Colors.grey[100],
          primaryColor: Colors.tealAccent[700],
          cardColor: Colors.white,
          textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.black,
                fontSize: 22, fontWeight: FontWeight.bold
            ),
            headline2: TextStyle(
                color: Colors.black,
                fontSize: 18, fontWeight: FontWeight.w500
            ),

            headline3: TextStyle(
                color: Colors.black,
                fontSize: 15, fontWeight: FontWeight.w500
            ),
            bodyText1 : TextStyle(
                color: Colors.black,
                fontSize: 15, fontWeight: FontWeight.w400
            ),
            bodyText2 : TextStyle(
                color: Colors.black,
                fontSize: 15, fontWeight: FontWeight.normal
            ),
            subtitle1: TextStyle(
                color: Colors.black54,
                fontSize: 14, fontStyle: FontStyle.italic),
            subtitle2: TextStyle(
                color: Colors.black54,
                fontSize: 12, fontStyle: FontStyle.italic),
          ),

        ),
        darkTheme: ThemeData(
          backgroundColor: Colors.grey[900],
          primaryColor: Colors.tealAccent[700],
          cardColor: Colors.black54,
          textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.white,
                fontSize: 22, fontWeight: FontWeight.bold
            ),
            headline2: TextStyle(
                color: Colors.white,
                fontSize: 18, fontWeight: FontWeight.w500
            ),
            headline3: TextStyle(
                color: Colors.white,
                fontSize: 15, fontWeight: FontWeight.w500
            ),

            bodyText1 : TextStyle(
                color: Colors.white.withOpacity(0.90),
                fontSize: 15, fontWeight: FontWeight.w400
            ),
            bodyText2 : TextStyle(
                color: Colors.white,
                fontSize: 15, fontWeight: FontWeight.normal
            ),
            subtitle1: TextStyle(
                color: Colors.white70,
                fontSize: 14, fontStyle: FontStyle.italic),
            subtitle2: TextStyle(
                color: Colors.white70,
                fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return MainScreenWrapper();
    } else {
       return LoginController();
    }
  }
}
