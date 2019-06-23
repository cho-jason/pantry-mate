import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenArguments {
  final DocumentSnapshot document;
  final String name;
  final unitVal;
  final String unitType;

  ScreenArguments(this.document, this.name, this.unitVal, this.unitType);
}
