// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:properties_app/widgets/custom_app_bar.dart';
import 'package:properties_app/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//This is the feed screen about houses... UserProfile was a mistake
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Container(
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
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Type Of Property',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        items: typesOfProperties.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => typeOfProperty = value),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        focusColor: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        value: district,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'District',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        focusColor: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        isExpanded: true,
                        value: rentalOrSale,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Rental',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        items: rentOrSales.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => rentalOrSale = value),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        focusColor: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        isExpanded: true,
                        value: priceRange,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Price Range',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        items: priceRanges.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => priceRange = value),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: typeOfProperty != null
                    ? FirebaseFirestore.instance
                        .collection('posts')
                        .where('typeOfProperty', isEqualTo: typeOfProperty)
                        .where('forSaleOrForRent', isEqualTo: rentalOrSale)
                        .snapshots()
                    : priceRange != null
                        ? FirebaseFirestore.instance
                            .collection('posts')
                            .where('price', isGreaterThanOrEqualTo: priceRange)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('posts')
                            .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
