import 'package:pantry_mate/model/ingredient.dart';

enum RecipeType {
  food,
  drink,
}

class Recipe {
  final int id;
  final RecipeType type;
  final String name;
  final Duration duration;
  final List<String> ingredients;
  final List<String> preparation;
  final String imageURL;

  const Recipe({
    this.id,
    this.type,
    this.name,
    this.duration,
    this.ingredients,
    this.preparation,
    this.imageURL,
  });
}
