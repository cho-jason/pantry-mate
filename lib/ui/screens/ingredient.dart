import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pantry_mate/model/ingredient.dart';
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
//       home: RandomWords(),
//     );
//   }
// }

class RandomWordsState extends State<RandomWords> {
  final List<String> _suggestions = <String>['Hi', 'Bye', "Test"];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRow(_suggestions[i]);
        });
  }

  Widget _buildRow(String ingredient) {
    return ListTile(
      title: Text(
        ingredient,
        style: _biggerFont,
      ),
      trailing: Icon(Icons.delete),
      onTap: () {
        setState(() {
          null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingredients'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: null,
        )
      ]),
      body: _buildSuggestions(),
    );
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
