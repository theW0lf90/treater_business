import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicesObject {
  final String name;
  bool selected;

  ServicesObject({this.name, this.selected});

}

class ServicesDataSource {
  List<ServicesObject> getServicesList(String compType) {
    List<ServicesObject> list = [];

    switch (compType) {
      case 'Beauty':
        {
          list.add(ServicesObject(name: 'Botox', selected: false));
          list.add(ServicesObject(name: 'Fillers', selected: false));
          list.add(ServicesObject(name: 'Hageløft', selected: false));
          list.add(ServicesObject(name: '3D øjenbryn', selected: false));
        }
        break;
      default:
        {
          list.add(ServicesObject(name: 'Akupunktur', selected: false));
          list.add(ServicesObject(name: 'Babybehandling', selected: false));
          list.add(ServicesObject(name: 'Cupping', selected: false));
          list.add(ServicesObject(name: 'Cryo', selected: false));
          list.add(ServicesObject(name: 'Dry needling', selected: false));
          list.add(ServicesObject(name: 'Graston Technique', selected: false));
          list.add(ServicesObject(name: 'Sports massage', selected: false));
          list.add(ServicesObject(name: 'Fysiurgisk massage', selected: false));
          list.add(
              ServicesObject(name: 'Deep tissue massage', selected: false));
          list.add(ServicesObject(name: 'Thai massage', selected: false));
          list.add(ServicesObject(name: 'Stramt tungebånd', selected: false));
        }
        break;
    }
    return list;
  }
}




