import 'package:flutter/material.dart';

class HomePageTabBar extends StatefulWidget {
  const HomePageTabBar({super.key});

  @override
  State<HomePageTabBar> createState() => _HomePageTabBarState();
}

class _HomePageTabBarState extends State<HomePageTabBar> {
  String? typeOfProperty;

  String? district;

  String? rentalOrSale;

  String? priceRange;

  final priceRanges = ['2000', '4000', '6000', '80000'];

  final rentOrSales = ['Per Month', 'For Sale'];

  final typesOfProperties = [
    'Stand alone House',
    'Townhouse',
    'Duplex',
    'Apartment',
    'Farm',
    'Vacant Land',
    'Commercial Property',
  ];

  final discricts = [
    'Maseru',
    'Leribe',
    'Berea',
    'Butha-Buthe',
    'Quthing',
    'Mohales Hoek',
    'Qachas Neck',
    'Mokhotlong',
    'Quthing',
    'Mafeteng'
  ];

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          item,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: ListView(scrollDirection: Axis.horizontal, children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 35,
              width: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black),
              child: DropdownButton<String>(
                dropdownColor: Colors.black,
                underline: Container(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10),
                focusColor: Colors.black,
                isExpanded: true,
                value: typeOfProperty,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Type Of Property',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                items: typesOfProperties.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => typeOfProperty = value),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                value: district,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('District'),
                ),
                items: discricts.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => district = value),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 35,
              width: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                value: rentalOrSale,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Rental'),
                ),
                items: rentOrSales.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => rentalOrSale = value),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                value: priceRange,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Price Range'),
                ),
                items: priceRanges.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => priceRange = value),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
