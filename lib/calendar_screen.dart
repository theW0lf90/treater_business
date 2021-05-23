import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Container(color: Colors.yellow,
    child: Center(child:Text(firebaseUser.email)));
  }
}
