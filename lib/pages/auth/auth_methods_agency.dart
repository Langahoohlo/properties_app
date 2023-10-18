import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:properties_app/resources/storage_methods.dart';
import '../../model/agency.dart' as model;

class AuthMethodsAgency {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<model.Agency> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.Agency.fromSnap(snap);
  }

  Future<String> signUpAgency({
    required String agencyEmail,
    required String agencyName,
    required String password,
    required String phoneNumbers,
    required String agencyBio,
    required Uint8List file,
    required String agencyOwner,
  }) async {
    String res = 'Some error happened';
    try {
      {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: agencyEmail, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //add user database

        model.Agency user = model.Agency(
            agencyName: agencyName,
            agencyEmail: agencyEmail,
            agencyPhoneNumbers: phoneNumbers,
            agencyPhotoUrl: photoUrl,
            agencyUid: cred.user!.uid,
            agencyBio: agencyBio,
            isVerified: false,
            agentsList: []);

        _firestore.collection('agencies').doc(cred.user!.uid).set(
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
