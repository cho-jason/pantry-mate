enum IngredientCategory {
  spice,
  can,
  sugar,
  fat,
  dairy,
  grain,
  fruit,
  meat,
  vegetable,
  misc,
}

class Ingredient {
  final String id;
  final IngredientCategory category;
  final String name;
  final int unitVal;
  final String unitType;
  final int userId;

  Ingredient.fromMap(Map<String, dynamic> data, String id)
      : this(
            id: id,
            category: IngredientCategory.values[data['category']],
            name: data['name'],
            unitVal: data['unitVal'],
            unitType: data['unitType']);

  const Ingredient({
    this.id,
    this.category,
    this.name,
    this.unitVal,
    this.unitType,
    this.userId,
  });
}
