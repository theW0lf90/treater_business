import 'package:flutter/material.dart';
import 'signedbusiness_model.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final businessData = context.watch<SignedBusiness>();


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),

          child: ListView(
            children: [
              DrawerHeader(
                child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(businessData.imgURL)

                        ),
                      )),

              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                  child: buildSectionHeader(context, 'Klienter')),
              Padding(padding: EdgeInsets.only(top: 10)),
              buildListTile(context, Icon(Icons.email_outlined), '3', 'Anmeldelser'),
              buildListTile(context, Icon(Icons.description_outlined),'', 'Journal'),
              buildListTile(context, Icon(Icons.calendar_today_outlined),'', 'Bookinger'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                  child: buildSectionHeader(context, 'Marketing')),
              buildListTile(context,Icon(Icons.campaign_outlined), '', 'Kampagner'),
              buildListTile(context,Icon(Icons.card_membership_outlined), '', 'Loyalitets rabat'),
            ],
          ),
        ),
      ),
    );
  }
  Padding buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(title, style: Theme.of(context).textTheme.headline2),
    );
  }

  ListTile buildListTile(BuildContext context, Icon icon, String itemCount, String title) {

    return ListTile(

      leading: icon,
      title:  Text(title, style: Theme.of(context).textTheme.headline3),
      trailing: itemCount != '' ?  Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),

        child: Center(child:Text(itemCount, style:
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold))) ,

      ): SizedBox.shrink(),
      // selected: true,
    );
  }
}
