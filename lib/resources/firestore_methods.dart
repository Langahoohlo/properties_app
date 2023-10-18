//import 'dart:js_util';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:properties_app/model/post.dart';
import 'package:properties_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //late CollectionReference imgRef;
  CollectionReference? imgRef;
  late firebase_storage.Reference ref;

  Future<String> uploadPost(
      String aboutHouse,
      String houseName,
      String houseLocation,
      String dateAvailable,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      String bedrooms,
      String bathrooms,
      String price,
      String garages,
      List<File> images,
      String forSaleOrRent,
      String agentName,
      String agentPhoneNumbers,
      String phoneNumbers,
      String agentWhatsApp,
      String typeOfProperty,
      String district) async {
    String res = "some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          houseName: houseName,
          aboutHouse: aboutHouse,
          houseLocation: houseLocation,
          dateAvailable: dateAvailable,
          postId: postId,
          postUrl: photoUrl,
          username: username,
          datePublished: DateTime.now(),
          uid: uid,
          profImage: profImage,
          likes: [],
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          price: price,
          garages: garages,
          images: [],
          forSaleOrForRent: forSaleOrRent,
          agentName: agentName,
          phoneNumbers: phoneNumbers,
          agentPhoneNumbers: agentPhoneNumbers,
          agentWhatsApp: agentWhatsApp,
          typeOfProperty: typeOfProperty,
          district: district);
      _firestore.collection('posts').doc(postId).set(post.toJson());

      for (var img in images) {
        CollectionReference imgRef = FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('collectionPath');

        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('houses/${Path.basename(img.path)}');
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            imgRef.add({'url': value});
          });
        });
      }
      imgRef = FirebaseFirestore.instance.collection('houses');
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
      //_firestore.collection('posts').doc(postId).collection('collectionPath').doc();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    try {
      _firestore.collection('posts').doc(postId).update(data);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> updateProfile(
      String uid, String username, Map<String, dynamic> data) async {
    try {
      _firestore.collection('users').doc(uid).set({'username': username});
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  //create a method to update the user profile in firebase
  Future<void> updateUsername(
      String uid, String username, Map<String, String> map) async {
    try {
      _firestore.collection('users').doc(uid).update({'username': username});
    } catch (err) {
      print(err.toString());
    }
  }
}
