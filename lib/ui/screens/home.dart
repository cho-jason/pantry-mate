import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_mate/ui/screens/ingredient.dart';
import 'package:pantry_mate/utils/camera.dart';

import 'package:pantry_mate/model/ingredient.dart';
import 'package:pantry_mate/utils/screen_arg.dart';
import 'package:pantry_mate/utils/store.dart';

import 'package:pantry_mate/model/user.dart';
import 'package:pantry_mate/model/recipe.dart';
import 'package:pantry_mate/ui/widgets/recipe_card.dart';

// DocumentReference ingredientsReference = Firestore.instance.collection('ingredients').document(uid)
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // List<Ingredient> ingredients = getIngredients();

  Widget _buildIngredients(/* List<Ingredient> ing */) {
    return StreamBuilder(
        stream: Firestore.instance.collection('ingredients').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildRow(snapshot.data.documents[index], index);
            },
          );
        });
  }

  Widget _buildRow(
      DocumentSnapshot document /* String name, int unitVal, String unitType */,
      index) {
    String id = document.documentID;
    String name = document['name'];
    var unitVal = document['unitVal'];
    String unitType = document['unitType'];
    String quantity = unitVal.toString() + ' ' + unitType;
    return ListTile(
        title: Text(name),
        subtitle: Text(quantity),
        trailing: IconButton(
            icon: Icon(Icons.edit),
            // onPressed: () => Navigator.pushNamed(context, '/ingredient')),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IngredientScreen(),
                      settings: RouteSettings(
                          arguments: ScreenArguments(
                              document, id, name, unitVal, unitType, index))));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingredient List'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                main();
              }));
            })
      ]),
      body: _buildIngredients(),
    );
  }
}
