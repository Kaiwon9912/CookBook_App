import 'dart:convert';
import 'package:dungeon_meshi/localData/saved_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/meal.dart';
import '../api_controller/fetch_data.dart';

class DetailPage extends StatefulWidget {
  final String id;

  DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {



  bool? _isFavorite;
  Meal meal = new Meal(idMeal: '', strMeal: '', strMealThumb: '', ingredients: []);
  SavedData db = new SavedData();
  void favoriteAction() {
    setState(() {


      if (_isFavorite==false) {
        SavedData.savedMeal.add(meal);
      } else {
        SavedData.savedMeal.removeWhere((meal)=>meal.idMeal == this.meal.idMeal);

      }
      _isFavorite = !_isFavorite!;
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<Meal>(
        future: Api_reader.fetchSingleMeal(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            meal = snapshot.data!;


            _isFavorite = SavedData.savedMeal.any((meal) => meal.idMeal == this.meal.idMeal);
            print(_isFavorite);

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(meal.strMealThumb),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                meal.strMeal,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  meal.strArea ?? "Unknown",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                IconButton(
                                  onPressed: favoriteAction,
                                  color: _isFavorite! ? Colors.red : Colors.black,
                                  icon: Icon(Icons.favorite),
                                )
                              ],
                            ),
                            Container(
                              height: 500,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: meal.ingredients.length,
                                itemBuilder: (context, index) {
                                  Ingredient? ingredient =
                                      meal.ingredients[index];

                                  return ListTile(
                                    tileColor: Colors.red,
                                    title: Text(ingredient!.name),
                                    subtitle: Text(ingredient.measure),
                                  );
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              child: Center(
                                                  child: Text(
                                                'Instructions',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      offset: Offset(0, 3),
                                                      blurRadius: 1,
                                                    )
                                                  ]),
                                            ),
                                            Container(
                                              height: 450,
                                              padding: EdgeInsets.all(25),
                                              child: SingleChildScrollView(
                                                child: Text(
                                                    meal.strInstructions ?? ""),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Center(
                                  child: const Text("Open instructions")),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
