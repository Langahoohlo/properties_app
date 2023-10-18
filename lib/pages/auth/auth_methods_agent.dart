import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:properties_app/resources/storage_methods.dart';
import '../../model/agent.dart' as model;

class AuthMethodsAgent {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<model.Agent> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.Agent.fromSnap(snap);
  }

  Future<String> signUpAgent(
      {required String email,
      required String username,
      required String password,
      required String phoneNumbers,
      required Uint8List file,
      required String agency}) async {
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

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //add user database

        model.Agent user = model.Agent(
          agency: agency,
          username: username,
          email: email,
          phoneNumbers: phoneNumbers,
          photoUrl: photoUrl,
          uid: cred.user!.uid,
          following: [],
          isVerified: false,
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
}
