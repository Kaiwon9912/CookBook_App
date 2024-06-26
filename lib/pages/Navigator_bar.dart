import 'package:dungeon_meshi/pages/categories_page.dart';
import 'package:dungeon_meshi/pages/saved_page.dart';
import 'package:dungeon_meshi/pages/search_page.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex =0;
  final List<Widget> _page=[
    CategoriesPage(),
    SearchPage(),
    SavedPage(),
  ];
  void onTapped(int index)
  {
    setState(() {

      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Color(0xFF992a21),

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,

      ),
    body: _page[_selectedIndex],
    );
  }
}
