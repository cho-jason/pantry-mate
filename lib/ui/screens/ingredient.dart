import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pantry_mate/utils/screen_arg.dart';
import 'package:pantry_mate/model/ingredient.dart';
import 'package:pantry_mate/utils/screen_arg.dart';
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
  final List<String> _suggestions = <String>['Hi', 'Bye', "Test"];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(ScreenArguments args) {
    String unitType = args.unitType;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            args.name,
            style: TextStyle(fontSize: 30.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
              // Container(
              //     decoration: const BoxDecoration(color: Color(0xffddddff)),
              //     child: ListTile(
              //       title: Text(args.unitVal.toString() + ' ' + args.unitType),
              //       onTap: () => Navigator.pop(context),
              //     ))
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffddddff)),
                    padding: const EdgeInsets.all(10.0),
                    child: Text(args.unitVal.toString() + ' ' + args.unitType),
                  )),
              IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: null),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed: () {}, child: Text('Save')),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              RaisedButton(onPressed: () {}, child: Text('Delete'))
            ],
          )
        ]);
    // return ListTile(
    //   title: Text(
    //     args.name,
    //     style: _biggerFont,
    //   ),
    //   trailing: Icon(Icons.delete),
    //   onTap: () {
    //     setState(() {
    //       null;
    //     });
    //   },
    // );
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
