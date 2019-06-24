import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenArguments {
  final DocumentSnapshot document;
  final String id;
  final String name;
  final unitVal;
  final String unitType;
  final int index;

  ScreenArguments(this.document, this.id, this.name, this.unitVal,
      this.unitType, this.index);
}
