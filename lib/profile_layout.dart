import 'package:flutter/material.dart';
import 'package:treater_business/company_model.dart';
import 'package:treater_business/company_queries.dart';


class ProfileLayout extends StatelessWidget {
  const ProfileLayout({Key key, this.collectionType, this.compId})
      : super(key: key);
  final String collectionType;
  final String compId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <Company>(
      future: CompanyQueries().getCompanyData(collectionType, compId),
      builder: (BuildContext context, AsyncSnapshot<Company> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Something went wrong')));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
            ),
            child: snapshot.data.imgURL.length > 3 ? Image.network(snapshot.data.imgURL, fit: BoxFit.cover) : Text('Upload Billede'),
          ),
        );
      },
    );
  }
}
