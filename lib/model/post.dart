//final String userTable = 'user';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:html';

class Post {
  final String houseName;
  final String aboutHouse;
  final String houseLocation;
  final String dateAvailable;
  final String postId;
  final String postUrl;
  final String username;
  final datePublished;
  final String uid;
  final String profImage;
  final likes;
  final String bedrooms;
  final String bathrooms;
  final String price;
  final String garages;
  final List<File> images;
  final String forSaleOrForRent;
  final String agentName;
  final String agentPhoneNumbers;
  final String agentWhatsApp;
  final String typeOfProperty;
  final String phoneNumbers;
  final String district;

  const Post(
      {required this.houseName,
      required this.aboutHouse,
      required this.postId,
      required this.houseLocation,
      required this.dateAvailable,
      required this.postUrl,
      required this.username,
      required this.datePublished,
      required this.uid,
      required this.profImage,
      required this.likes,
      required this.bedrooms,
      required this.bathrooms,
      required this.price,
      required this.garages,
      required this.images,
      required this.forSaleOrForRent,
      required this.agentName,
      required this.agentPhoneNumbers,
      required this.agentWhatsApp,
      required this.typeOfProperty,
      required this.district,
      required this.phoneNumbers});

  Map<String, dynamic> toJson() => {
        "houseName": houseName,
        "aboutHouse": aboutHouse,
        "houseLocation": houseLocation,
        "dateAvailable": dateAvailable,
        "postId": postId,
        "postUrl": postUrl,
        "username": username,
        "datePublished": datePublished,
        "uid": uid,
        "profImage": profImage,
        "likes": likes,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "price": price,
        "garages": garages,
        "images": images,
        "forSaleOrForRent": forSaleOrForRent,
        "agentName": agentName,
        "agentPhoneNumbers": agentPhoneNumbers,
        "agentWhatsApp": agentWhatsApp,
        "typeOfProperty": typeOfProperty,
        "district": district
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        houseName: snapshot['houseName'],
        aboutHouse: snapshot['aboutHouse'],
        houseLocation: snapshot['houseLocation'],
        dateAvailable: snapshot['dateAvailable'],
        postId: snapshot['postId'],
        postUrl: snapshot['postUrl'],
        username: snapshot['username'],
        datePublished: snapshot['datePublished'],
        uid: snapshot['uid'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes'],
        bedrooms: snapshot['bedrooms'],
        bathrooms: snapshot['bathrooms'],
        price: snapshot['price'],
        garages: snapshot['garages'],
        images: snapshot['images'],
        forSaleOrForRent: snapshot['forSaleOrForRent'],
        agentName: snapshot['agentName'],
        agentPhoneNumbers: snapshot['agentPhoneNumbers'],
        agentWhatsApp: snapshot['agentWhatsApp'],
        typeOfProperty: snapshot['typeOfProperty'],
        phoneNumbers: snapshot['phoneNumbers'],
        district: snapshot['district']);
  }
}
