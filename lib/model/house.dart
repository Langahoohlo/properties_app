//import 'dart:html';

import 'package:flutter/material.dart';

const String houseTable = 'houselist';

class House {
  //String userName;
  //String uploaded
  String houseName;
  String address;
  String imageUrl;
  String size;
  String price;

  //static final List<String> allFields = [name, address, imageUrl, size, price];

  House(this.houseName, this.address, this.imageUrl, this.size, this.price);

  static List<House> generateRecommended() {
    return [
      House('Town House', '123 Maseru, Ha Thetsane', 'assets/images/house1.jpg',
          '500 square meters', 'M7500/pm'),
      House('Cabin', '123 Maseru, Roma', 'assets/images/house2.jpg',
          '500 square meters', 'M5400/pm')
    ];
  }

  static List<House> generateBestOffer() {
    return [
      House('Luxury', '123 Maseru, Masowe West', 'assets/images/luxury.jpg',
          '2000 square meters', 'M15000/pm'),
      House('Farm', '123 Maseru, Qeme', 'assets/images/farm.jpg', '4000 acres',
          'M1 200 000')
    ];
  }
}

class HouseFields {
  static const String username = 'username';
  static const String title = 'title';
  static const String done = 'done';
  static const String created = 'created';
  static final List<String> allFields = [username, title, done, created];
}

class HouseData {
  final String username;
  final String title;
  bool done;
  final DateTime created;

  HouseData(
      {required this.username,
      required this.title,
      this.done = false,
      required this.created});

  Map<String, Object?> toJson() => {
        HouseFields.username: username,
        HouseFields.title: title,
        HouseFields.done: done ? 1 : 0,
        HouseFields.created: created.toIso8601String()
      };

  @override
  bool operator ==(covariant HouseData houseData) {
    return (username == houseData.username) &&
        (title.toUpperCase().compareTo(houseData.title.toUpperCase()) ==
            0);
  }

  @override
  int get hashcode {
    return hashValues(username, title);
  }
}
