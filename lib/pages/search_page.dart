import 'package:flutter/material.dart';

import '../Model/meal.dart';
import '../api_controller/fetch_data.dart';
import '../component/meal_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});


  @override
  State<SearchPage> createState() => _SearchPageState();


}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchInput = TextEditingController();
  String search()
  {
   setState(() {
    print('called');
   });
   return searchInput.text;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (pure)
                    {
                      setState(() {

                      });
                    },
                    controller: searchInput,
                    decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search,size: 30,color: Colors.purple,),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),

              ],
            )
            ,
            Container(
              child: Expanded(
                child: FutureBuilder<List<Meal>>(
                  future: Api_reader.fetchSearchMeals(searchInput.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Column(children: [
                        Text('NO MEAL FOUND',style: TextStyle(fontSize: 40),),
                        Image(image: AssetImage('lib/images/error.jpg'))
                      ],);
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No meals found'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final meal = snapshot.data![index];
                        return MealTile(meal: meal, isSaved: false);
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
