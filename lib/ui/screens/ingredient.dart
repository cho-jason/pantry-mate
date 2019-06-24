import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pantry_mate/utils/screen_arg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_mate/services/crud.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       theme: ThemeData(
//         // Add the 3 lines from here...
//         primaryColor: Colors.white,
//       ),
//       home: IngredientScreen(),
//     );
//   }
// }

class IngredientScreenState extends State<IngredientScreen> {
  // final List<String> _suggestions = <String>['Hi', 'Bye', "Test"];
  // final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  // @override
  // void initState() {
  //   setState(() {
  //     String name = args.name;
  //   });
  //   super.initState();
  // }

  final crudObj = new CrudMethods();
  var unitVal;

  Widget _buildRow(ScreenArguments args) {
    // String unitType = args.unitType;
    return StreamBuilder(
        stream: Firestore.instance.collection('ingredients').snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot doc = snapshot.data.documents[args.index];
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(80.0),
                ),
                Text(doc['name'], style: TextStyle(fontSize: 30.0)),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () async {
                          if (doc['unitVal'] <= 1) {
                            Navigator.of(context).pop();
                            await crudObj.deleteData(doc.documentID);
                          } else {
                            await crudObj.updateData(doc.documentID,
                                {'unitVal': doc['unitVal'] - 1});
                          }
                        }),
                    GestureDetector(
                        onTap: () {
                          updateDialog(context, doc, doc['unitType']);
                        },
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.black12),
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              doc['unitVal'].toString() + ' ' + doc['unitType'],
                              style: TextStyle(fontSize: 18)),
                        )),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await crudObj.updateData(
                              doc.documentID, {'unitVal': doc['unitVal'] + 1});
                        }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Go Back',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue),
                Padding(
                  padding: EdgeInsets.all(70.0),
                ),
                RaisedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await crudObj.deleteData(doc.documentID);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  color: Colors.red,
                )
              ]);
        });
  }

  Future<bool> updateDialog(
      BuildContext context, DocumentSnapshot doc, String unitType) async {
    if (unitType == 'whole') {
      unitType = 'quantity';
    } else if (unitType == 'ounces' ||
        unitType == 'grams' ||
        unitType == 'pounds') {
      unitType = 'weight';
    } else {
      unitType = 'volume';
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update ' + unitType + '.'),
            content: Container(
                height: 50.0,
                width: 150.0,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Enter a number.'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    this.unitVal = double.parse(value);
                    if (this.unitVal % 1 == 0) this.unitVal = int.parse(value);
                  },
                  onSubmitted: (value) async {
                    Navigator.of(context).pop();
                    if (value != 0) {
                      await crudObj
                          .updateData(doc.documentID, {'unitVal': value});
                    } else {
                      await crudObj.deleteData(doc.documentID);
                    }
                  },
                )),
            actions: <Widget>[
              RaisedButton(
                child: Text('Update'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (this.unitVal != 0) {
                    await crudObj
                        .updateData(doc.documentID, {'unitVal': this.unitVal});
                  } else {
                    await crudObj.deleteData(doc.documentID);
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Ingredient: ' + args.name)),
      body: _buildRow(args),
    );
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
  }
}

class IngredientScreen extends StatefulWidget {
  @override
  IngredientScreenState createState() => IngredientScreenState();
}
