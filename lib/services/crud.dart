import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> createData(data) async {
    Firestore.instance
        .collection('ingredients')
        .add(data)
        .catchError((e) => print(e));
  }

  Future<void> updateData(String id, data) async {
    Firestore.instance
        .collection('ingredients')
        .document(id)
        .updateData(data)
        .catchError((e) => print(e));
  }

  Future<void> deleteData(String id) async {
    Firestore.instance
        .collection('ingredients')
        .document(id)
        .delete()
        .catchError((e) => print(e));
  }
}
