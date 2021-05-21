import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),
      leading: IconButton(icon: Icon(Icons.chevron_left),),
      ),
      body: Container(color: Colors.blue, child: Text(firebaseUser.email),
      ),
    );
  }
}
