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
  final int id;
  final IngredientCategory category;
  final String name;
  final int unitVal;
  final String unitType;
  final int userId;

  const Ingredient({
    this.id,
    this.category,
    this.name,
    this.unitVal,
    this.unitType,
    this.userId,
  });
}
