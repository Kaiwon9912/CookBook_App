import 'dart:ui';

import 'package:flutter/material.dart';

import '../Model/category.dart';

class CategoriesTile extends StatelessWidget {
  final Category category;


  const CategoriesTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 30),
      
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow:[ BoxShadow(
            color: Colors.grey.withOpacity(0.5), // color of the shadow
            spreadRadius: 1, // spread radius
      
            offset: Offset(0, 3), // changes position of shadow
          )
      ]
        ),
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: 0.5,
                child: Image.network(
                  category.strCategoryThumb,
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Center(
              child:  Text(category.strCategory,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 1),
      
                        blurRadius: 1,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
