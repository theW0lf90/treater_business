import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treater_business/company_queries.dart';
import 'package:treater_business/services_data.dart';
import 'package:provider/provider.dart';

class SelectServices extends StatefulWidget {
  final String compType;
  final String linkedUid;
  const SelectServices({Key key, this.compType, this.linkedUid}) : super(key: key);

  @override
  _SelectServicesState createState() => _SelectServicesState();
}

class _SelectServicesState extends State<SelectServices> {
  List<ServicesObject> listOfServiceObjects = [];
  List<String> listForUpload = [];

  @override
  void initState() {

    super.initState();
    listOfServiceObjects = ServicesDataSource().getServicesList(widget.compType);
    print('list of services count' + listOfServiceObjects.length.toString());
  }

  @override
  Widget build(BuildContext context) {
   // final businessData = context.watch<SignedBusiness>();
    final user = context.watch<User>();

    return Dialog(
      backgroundColor: Theme.of(context).backgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(

          floatingActionButton:  FloatingActionButton.extended(onPressed: () {
            if(listForUpload.length > 1) {
              CompanyQueries().updateMySkills(user, listForUpload, widget.compType, widget.linkedUid);

            } else {
              print('Vælg mindst en kompetence');
            }

          },
            icon: Icon(Icons.check_outlined),
            label: Text('Upload'),
            elevation: 0,
            backgroundColor: listForUpload.length < 1? Colors.grey[400]: Theme.of(context).primaryColor,
          ),
          body:
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Correctme', style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Vælg dine services', style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
                  child: Container(
                 //   padding: EdgeInsets.only(bottom: 70),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: new ListView(
                      shrinkWrap: true,
                      children: listOfServiceObjects.map((ServicesObject serviceObject) {
                        return new ListTile(

                          title: new Text(serviceObject.name, style: Theme.of(context).textTheme.bodyText2),
                        //  leading: Icon(serviceObject.icon.icon, color: serviceObject.color),
                          trailing: serviceObject.selected? Icon(Icons.remove_circle_outline_outlined, color: Colors.red,) : Icon(Icons.add_circle_outline_outlined, color: Colors.green),
                          onTap: () {

                            if(serviceObject.selected == false) {
                              setState(() {
                                serviceObject.selected = true;
                                listForUpload.add(serviceObject.name);
                                print('added item ' + serviceObject.name + ' length of list ' + listOfServiceObjects.length.toString());


                              });
                            } else {
                              setState(() {
                                serviceObject.selected = false;
                                listForUpload.remove(serviceObject.name);
                                  print('removed item ' + serviceObject.name + ' length of list ' + listForUpload.length.toString());

                                String tempString = '';


                                serviceObject.name.characters.forEach((char) {
                                  tempString += char.toLowerCase();
                                  print('im tempstr $tempString');

                                  if(listOfServiceObjects.contains(tempString)) {
                                    print('match found $tempString');
                                    listOfServiceObjects.remove(tempString);

                                  }
                                });



                                /*   String tempString = '';
                                competence.name.characters.forEach((element) {
                                  // print(element);
                                  tempString = tempString.toLowerCase() + element.toLowerCase();

                                  listForUpload.forEach((element) {
                                    if(tempString == element) {
                                      print('found match $tempString $element');
                                      listForUpload.remove(tempString);
                                    }
                                  });


                               //   listForUpload.remove(tempString);
                                  print(tempString);
                                });

                              */
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
