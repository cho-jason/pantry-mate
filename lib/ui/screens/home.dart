import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pantry_mate/model/user.dart';
import 'package:pantry_mate/model/ingredient.dart';
import 'package:pantry_mate/model/recipe.dart';
import 'package:pantry_mate/ui/widgets/recipe_card.dart';
import 'package:pantry_mate/utils/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Ingredient> ingredients = getIngredients();

  Widget _buildIngredients() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: ingredients.length,
      itemBuilder: (BuildContext context, int index) {
        Ingredient ing = ingredients[index];
        return _buildRow(ing.name, ing.unitVal, ing.unitType);
      },
    );
  }

  Widget _buildRow(String name, int unitVal, String unitType) {
    String quantity = unitVal.toString() + ' ' + unitType;
    return ListTile(
      title: Text(name),
      subtitle: Text(quantity),
      trailing: Icon(Icons.edit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingredient List'), actions: <Widget>[
        IconButton(icon: Icon(Icons.camera_alt), onPressed: null)
      ]),
      body: _buildIngredients(),
    );
  }
}
