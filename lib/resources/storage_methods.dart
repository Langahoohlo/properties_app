import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cross_file/src/types/interface.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference imgRef;
  //late firebase_storage.Reference ref;

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadHousesToStorage(
      String childName, Uint8List file, bool isPost, List<File> images) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    for (var img in images) {
      CollectionReference imgRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(childName)
          .collection('collectionPath');

      Reference ref = FirebaseStorage.instance
          .ref()
          .child('houses/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
        });
      });
    }

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);

      // for (var img in images) {
      //   ref = _storage.ref().child('houses/${Path.basename(img.path)}');
      //   await ref.putFile(img).whenComplete(() async {
      //     await ref.getDownloadURL().then((value) {
      //       imgRef.add({'url': value});
      //     });
      //   });
      // }
      // imgRef = FirebaseFirestore.instance.collection('houses');
    }

    UploadTask uploadTask = ref.putData(file);

    // TaskSnapshot snap = await uploadTask;
    // String downloadUrl = await snap.ref.getDownloadURL();
    // return downloadUrl;
    //UploadTask uploadTask = ref.putFile(File(file.path));
    await uploadTask.whenComplete(() {
      // setState(() {
      //   uploadItem++;
      //   if (uploadItem == _selectedFiles.length) {
      //     _isUploading = false;
      //     uploadItem = 0;
      //   }
      // });
    });
    return await ref.getDownloadURL();
  }
}
