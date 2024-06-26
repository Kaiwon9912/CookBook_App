import 'package:dungeon_meshi/pages/detail_page.dart';
import 'package:dungeon_meshi/pages/saved_meal.dart';
import 'package:flutter/material.dart';


import '../Model/meal.dart';
class MealTile extends StatelessWidget {
  final Meal meal;
  final isSaved;
  const MealTile({super.key, required this.meal, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    String MealStr(String mealStr)
    {
      return mealStr.length>25? mealStr.substring(0,25) +"...": mealStr;
    }
    void NavigatorToDetail(String id, bool isSaved)
    {
      if(!isSaved)  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(id: id)));
      else Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedDetail(meal: meal)));
    }
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>NavigatorToDetail(meal.idMeal, isSaved),
        child: Container(

          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // color of the shadow
                spreadRadius: 1, // spread radius

                offset: Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.network(meal.strMealThumb),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  MealStr(meal.strMeal), style: TextStyle(fontSize: 16),

                ),


              )
            ],
          ),

        ),
      ),
    );
  }
}
