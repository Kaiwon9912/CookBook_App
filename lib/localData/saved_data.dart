import 'package:dungeon_meshi/Model/meal.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedData
{
  final _box = Hive.box('myBox');
  static List<Meal> savedMeal = [];


  void updateDatabase()
  {
    _box.put("saved_meal", savedMeal);
  }
  void loadDatabase() {
    savedMeal = List<Meal>.from(_box.get('saved_meal', defaultValue: []));
  }

}