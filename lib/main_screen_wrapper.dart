import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treater_business/company_queries.dart';
import 'package:treater_business/main_screen.dart';
import 'package:treater_business/signedbusiness_model.dart';

class MainScreenWrapper extends StatelessWidget {
  const MainScreenWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User>();
   // var signedBusiness = CompanyQueries().getSignedBusinessData(firebaseUser.uid)
   // FirebaseAuth.instance.signOut();
    return FutureProvider<SignedBusiness?>(
        initialData: null,
        create: (context) => CompanyQueries().getSignedBusinessData(firebaseUser.uid),
    child: MainScreen());
  }
}
