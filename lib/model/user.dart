//final String userTable = 'user';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:html';

class User {
  final String username;
  final String email;
  final String phoneNumbers;
  //final String photoUrl;
  final String uid;
  final List followers;
  final List following;
  final bool paid;

  const User({
    required this.username,
    required this.email,
    required this.phoneNumbers,
    //required this.photoUrl,
    required this.uid,
    required this.followers,
    required this.following,
    required this.paid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phoneNumbers": phoneNumbers,
        //"photoUrl": photoUrl,
        "uid": uid,
        "followers": followers,
        "following": following,
        "paid": paid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot['username'],
        email: snapshot['email'],
        phoneNumbers: snapshot['phoneNumbers'],
        //photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        paid: snapshot['paid']);
  }
}
