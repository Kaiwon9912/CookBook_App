import 'dart:convert';

import '../Model/category.dart';
import '../Model/meal.dart';
import 'package:http/http.dart' as http;
class Api_reader {

 static Future<List<Category>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['categories'];
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

 static Future<List<Meal>> fetchCategoryMeal(String category) async {
    String url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=';
    final response = await http.get(Uri.parse(url + category));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['meals'];
      return data.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
  static Future<Meal> fetchSingleMeal(String id) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=' + id));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final mealData = data['meals'][0]; // Accessing the first meal in the list
      return Meal.fromJson(mealData as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Meal');
    }
  }
 static Future<List<Meal>> fetchSearchMeals(String search) async {
   String url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';
   final response = await http.get(Uri.parse(url + search));

   if (response.statusCode == 200) {

     List<dynamic> data = json.decode(response.body)['meals'];
     return data.map((json) => Meal.fromJson(json)).toList();
   } else {
     throw Exception('Failed to load meals');
   }
 }
}
