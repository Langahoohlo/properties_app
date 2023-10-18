//final String userTable = 'user';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:html';

class Agent {
  final String username;
  final String email;
  final String phoneNumbers;
  final String photoUrl;
  final String uid;
  final String agency;
  final List following;
  final bool isVerified;

  const Agent({
    required this.username,
    required this.email,
    required this.phoneNumbers,
    required this.photoUrl,
    required this.uid,
    required this.agency,
    required this.following,
    required this.isVerified,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phoneNumbers": phoneNumbers,
        "photoUrl": photoUrl,
        "uid": uid,
        "followers": agency,
        "following": following,
        "paid": isVerified,
      };

  static Agent fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Agent(
        username: snapshot['username'],
        email: snapshot['email'],
        phoneNumbers: snapshot['phoneNumbers'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        agency: snapshot['followers'],
        following: snapshot['following'],
        isVerified: snapshot['paid']);
  }
}
