import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pantry_mate/utils/camera_arg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_mate/services/crud.dart';

class CameraListScreenState extends State<CameraListScreen> {
  final crudObj = new CrudMethods();
  final List<String> name = [];
  final List<String> category = [];
  final List<String> unitType = [];
  final List<dynamic> unitVal = [];

  Widget buildList(CameraListArguments args) {
    final List<String> list = args.cameraList;
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        print(list[index]);
        return _buildRow(list[index], index);
      },
    );
  }

  Widget _buildRow(cameraList, int index) {
    return Form(
        child: Column(
      children: <Widget>[
        Text(
          'Ingredient ' + (index + 1).toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
        ),
        Text(
          'Ingredient Name:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        TextFormField(
          initialValue: cameraList,
          textAlign: TextAlign.center,
          onSaved: (input) => this.name[index] = input.toLowerCase(),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
        ),
        Text(
          'Category:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Type in a category'),
          textAlign: TextAlign.center,
          onSaved: (input) => this.category[index] = input.toLowerCase(),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
        ),
        Text(
          'Unit of Measurment:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'e.g. gallons, ounces, etc.'),
          textAlign: TextAlign.center,
          onSaved: (input) {
            print(input);
            this.unitType[index] = input.toLowerCase();
          },
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
        ),
        Text(
          'Unit Value:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(hintText: 'TEST'),
          onChanged: (input) {
            this.unitVal[index] = int.parse(input);
            print(this.unitVal[index]);
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'quantity / volume / weight'),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onSaved: (input) {
            print(input);
            this.unitVal[index] = int.parse(input);
          },
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: RaisedButton(
            padding: EdgeInsets.all(10.0),
            color: Colors.blue,
            child: Text('Add'),
            onPressed: () {
              print('This is the index: ' + index.toString());
              print('Name: ' + this.unitVal.length.toString());
              print('Category: ' + this.category[index]);
              print('UnitType: ' + this.unitType[index]);
              print('unitVal: ' + this.unitVal[index]);

              crudObj.createData({
                "name": this.name[index],
                "category": this.category[index],
                "unitType": this.unitType[index],
                "unitVal": this.unitVal[index]
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(40.0),
        )
      ],
    ));

    /* return ListTile(
      title: Text(cameraList),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => createDialog(context, cameraList),
      ),
    ); */
  }

  Future<bool> updateName(BuildContext context, String name) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Ingredient Name'),
            content: Container(
                height: 50.0,
                width: 150.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Ingredient Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.black12),
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Test'),
                      ),
                      onTap: null,
                    ),
                    Text('Ingredient Category'),
                    TextField(
                      decoration:
                          InputDecoration(hintText: 'Ingredient Category'),
                      // onChanged: (value) {
                      //   this.name = value.toLowerCase();
                      // },
                    ),
                    /* // Category
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
                    ), */
                  ],
                )),
            actions: <Widget>[
              RaisedButton(
                child: Text('Add'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.of(context).pop();

                  /* await crudObj.createData({
                    'name': this.name,
                    'category': this.category,
                    'unitVal': this.unitVal,
                    'unitType': this.unitType
                  }); */
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final CameraListArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Text Detected in Image')),
      body: buildList(args),
      // body: Text('Hello')
    );
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
  }
}

class CameraListScreen extends StatefulWidget {
  @override
  CameraListScreenState createState() => CameraListScreenState();
}
