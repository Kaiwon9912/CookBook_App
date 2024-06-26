import 'package:dungeon_meshi/Model/meal.dart';
import 'package:dungeon_meshi/api_controller/fetch_data.dart';
import 'package:dungeon_meshi/component/meal_tile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/category.dart';
import '../component/catergories_tile.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {


  String _Category = "Beef";

  

  void filterCategory(String category)
  {
    setState(() {
      _Category = category;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset('lib/images/background.jpg'),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 10,
                  color:  Color(0xFF992a21),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100,
              child: Expanded(
                child: FutureBuilder<List<Category>>(
                  future: Api_reader.fetchCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No categories found'));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        return GestureDetector(
                          onTap: ()=>filterCategory(category.strCategory),
                            child: CategoriesTile(category: category));
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(

                alignment: Alignment.topLeft,
                child: Text(
                  _Category, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: FutureBuilder<List<Meal>>(
                  future: Api_reader.fetchCategoryMeal(_Category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No meals found'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final meal = snapshot.data![index];
                        return MealTile(meal: meal, isSaved: false,);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
