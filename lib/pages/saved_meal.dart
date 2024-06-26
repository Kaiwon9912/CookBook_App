import 'dart:convert';
import 'package:dungeon_meshi/localData/saved_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/meal.dart';


class SavedDetail extends StatefulWidget {
  final Meal meal;
  SavedDetail({super.key, required this.meal});

  @override
  State<SavedDetail> createState() => _SavedDetailState();
}

class _SavedDetailState extends State<SavedDetail> {
  bool _isFavorite = true;

  SavedData db = new SavedData();


  void favoriteAction() {
    setState(() {


      if (_isFavorite==false) {
        SavedData.savedMeal.add(widget.meal);
      } else {
        SavedData.savedMeal.removeWhere((meal)=>meal.idMeal == this.widget.meal.idMeal);

      }
      _isFavorite = !_isFavorite;
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    Meal meal = widget.meal;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
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
                              color: _isFavorite ? Colors.red : Colors.black,
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
        )
    );



  }
}


