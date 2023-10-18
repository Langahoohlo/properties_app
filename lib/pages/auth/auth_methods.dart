import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:properties_app/model/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String phoneNumbers,
    //required Uint8List file
  }) async {
    String res = 'Some error happened';
    try {
      if (email.isNotEmpty || password.isNotEmpty
          // phoneNumbers.isNotEmpty ||
          // username.isNotEmpty
          //&& file.isNotEmpty
          ) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profilePics', file, false);

        //add user database

        model.User user = model.User(
          username: username,
          email: email,
          phoneNumbers: phoneNumbers,
          //photoUrl: photoUrl,
          uid: cred.user!.uid,
          followers: [],
          following: [],
          paid: false,
        );

        _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      print(err);
      res = err.toString();
    }

    return res;
  }

  // UserCredential userCredential = await FirebaseAuth.instance
  //     .createUserWithEmailAndPassword(
  //         email: _agencyEmail.text.trim(),
  //         password: _passwordController.text.trim());

  // User? user = userCredential.user;

  // if (user != null) {
  //   await FirebaseFirestore.instance
  //       .collection("agencies")
  //       .doc(user.uid)
  //       .set({
  //     "agencyName": _agencyName.text.trim(),
  //     "agencyEmail": _agencyEmail.text.trim(),
  //     "agencyPhoneNumbers": _agencyPhoneNumbers.text.trim(),
  //     "agencyPhotoUrl": _image!,
  //     "agencyUid": user.uid,
  //     "agencyBio": _agencyBio.text.trim(),
  //     "agencyFollowers": [],
  //     "isVerified": false,
  //   });

  //   await user.sendEmailVerification();

  //   await user.updateProfile(displayName: _agencyName.text.trim());

  //   await user.reload();

  //   Navigator.of(context).pop();
}
