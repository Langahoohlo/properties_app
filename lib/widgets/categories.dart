// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:properties_app/categories/top_recomended.dart';

import 'tabBar/agency_recomended.dart';
import 'tabBar/most_popular.dart';
import 'tabBar/near_you.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<String> categoriesList = [
    //create a instance of each category
    'Top Recommended',
    'Near You',
    'Agency Picks',
    'Most Popular',
    //TopRecommended(),
    // NearYou(),
    // AgencyRecomended(),
    // MostPopular()
  ];

  final List<Widget> categoriesWidget = [
    TopRecommended(),
    NearYou(),
    AgencyRecomended(),
    MostPopular()
  ];

  int currentSelect = 0;

  void navigateExplore(int index) {
    setState(() {
      currentSelect = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text('Categories'),
        //   ),body:
        Container(
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView.builder(
                itemCount: categoriesList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentSelect = index;
                          });
                        },
                        child: AnimatedContainer(
                          margin: EdgeInsets.all(5),
                          width: 120,
                          height: 45,
                          decoration: BoxDecoration(
                              color: currentSelect == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1,
                              )),
                          duration: const Duration(milliseconds: 300),
                          child: Center(
                              child: Text(
                            categoriesList[index],
                            style: TextStyle(
                                color: currentSelect == index
                                    ? Colors.blue
                                    : Colors.black,
                                fontSize: 12,
                                fontWeight: currentSelect == index
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )),
                        ),
                      ),
                    ],
                  );
                })),
          ),
          Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 600,
              child: Column(
                children: [categoriesWidget[currentSelect]],
                //List<Widget>categoriesWidget[currentSelect]
              ))
        ],
      ),
    );
    //);
  }
}
