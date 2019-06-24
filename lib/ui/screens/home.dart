import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_mate/ui/screens/camera_list.dart';
import 'package:pantry_mate/ui/screens/ingredient.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:pantry_mate/utils/camera.dart';
import 'package:pantry_mate/services/crud.dart';

import 'package:pantry_mate/model/ingredient.dart';
import 'package:pantry_mate/utils/screen_arg.dart';
import 'package:pantry_mate/utils/camera_arg.dart';
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
  final crudObj = new CrudMethods();

  String name;
  String category;
  String unitType;
  var unitVal;

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

  Future<bool> createDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add an Ingredient'),
            content: Container(
                height: 180.0,
                width: 150.0,
                child: Column(
                  children: <Widget>[
                    // Name
                    TextField(
                      decoration: InputDecoration(hintText: 'Ingredient Name'),
                      onChanged: (value) {
                        this.name = value.toLowerCase();
                      },
                    ),
                    // Category
                    TextField(
                      decoration:
                          InputDecoration(hintText: 'Ingredient Category'),
                      onChanged: (value) {
                        this.category = value.toLowerCase();
                      },
                    ),
                    // UnitType
                    TextField(
                      decoration:
                          InputDecoration(hintText: 'Unit of Measurement'),
                      onChanged: (value) {
                        this.unitType = value.toLowerCase();
                      },
                    ),
                    // UnitVal
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Quantity / Volume / Weight'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        this.unitVal = double.parse(value);
                        if (this.unitVal % 1 == 0)
                          this.unitVal = int.parse(value);
                      },
                    ),
                  ],
                )),
            actions: <Widget>[
              RaisedButton(
                child: Text('Add'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.of(context).pop();

                  await crudObj.createData({
                    'name': this.name,
                    'category': this.category,
                    'unitVal': this.unitVal,
                    'unitType': this.unitType
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<String> textList = [];
    return Scaffold(
      appBar: AppBar(title: Text('Ingredient List'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () async {
              final File imageFile =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              final FirebaseVisionImage visionImage =
                  FirebaseVisionImage.fromFile(imageFile);
              TextRecognizer textRecognizer =
                  FirebaseVision.instance.textRecognizer();
              final VisionText visionText =
                  await textRecognizer.processImage(visionImage);
              // String text = visionText.text;
              for (TextBlock block in visionText.blocks) {
                // final Rect boundingBox = block.boundingBox;
                // final List<Offset> cornerPoints = block.cornerPoints;
                final String text = block.text;
                // print('THIS IS DA TEXT:' + text);
                textList.add(text);
                // final List<RecognizedLanguage> languages =
                //     block.recognizedLanguages;
                // for (TextLine line in block.lines) {
                // Same getters as TextBlock
                // for (TextElement element in line.elements) {
                //   // Same getters as TextBlock
                //   print('THIS IS DA ELEMENT: ' + element.text + '\n');
                // }
                // }
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CameraListScreen(),
                      settings: RouteSettings(
                          arguments: CameraListArguments(textList))));

              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   main();
              // }));
            })
      ]),
      body: _buildIngredients(),
      persistentFooterButtons: <Widget>[
        ButtonBar(
          children: <Widget>[
            Text(
              'Add Ingredient',
              style: TextStyle(fontSize: 16.0),
            ),
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 30.0,
              onPressed: () => createDialog(context),
            )
          ],
        )
      ],
    );
  }
}
