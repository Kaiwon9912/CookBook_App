import 'package:dungeon_meshi/component/meal_tile.dart';
import 'package:dungeon_meshi/localData/saved_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final saved = Hive.box('myBox');
  SavedData db = SavedData();

  @override
  void initState() {
    super.initState();
    db.loadDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            color: Color(0xFF992a21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved Meal',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
              child: SavedData.savedMeal.isNotEmpty
                  ? ListView.builder(
                      itemCount: SavedData.savedMeal.length,
                      itemBuilder: (context, index) {
                        return MealTile(
                          meal: SavedData.savedMeal[index],
                          isSaved: true,
                        );
                      },
                    )
                  : Container(
                      color: Color(0xFFE2D4B7),
                      child: Column(
                        children: [
                          Text(
                            'Your list is Empty',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(2, 1),
                                    blurRadius: 3,
                                  ),
                                ]),
                          ),
                          Text(
                            'Save some meal !!!',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(2, 1),
                                    blurRadius: 3,
                                  ),
                                ]),
                          ),
                          Image(image: AssetImage('lib/images/senshi.jpg'))
                        ],
                      ),
                    )),
        ],
      ),
    );
  }
}
