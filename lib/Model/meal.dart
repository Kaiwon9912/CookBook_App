import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal {
  @HiveField(0)
  final String idMeal;

  @HiveField(1)
  final String strMeal;

  @HiveField(2)
  final String? strDrinkAlternate;

  @HiveField(3)
  final String? strCategory;

  @HiveField(4)
  final String? strArea;

  @HiveField(5)
  final String? strInstructions;

  @HiveField(6)
  final String strMealThumb;

  @HiveField(7)
  final String? strTags;

  @HiveField(8)
  final String? strYoutube;

  @HiveField(9)
  final List<Ingredient> ingredients;

  Meal({
    required this.idMeal,
    required this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredientName = json['strIngredient$i'];
      String? ingredientMeasure = json['strMeasure$i'];
      if (ingredientName != null && ingredientName.isNotEmpty) {
        ingredients.add(Ingredient(name: ingredientName, measure: ingredientMeasure ?? ''));
      }
    }

    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}

@HiveType(typeId: 1)
class Ingredient {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String measure;

  Ingredient({required this.name, required this.measure});
}
