import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class MultiImage extends StatefulWidget {
  const MultiImage({super.key});

  @override
  _MultiImageState createState() => _MultiImageState();
}

class _MultiImageState extends State<MultiImage> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedFiles = [];
  late storage.Reference ref;
  late CollectionReference imgRef;

  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Image Page'),
        actions: [
          FloatingActionButton(
            onPressed: () {
              uploadFile();
              //.whenComplete(() => Navigator.of(context).pop());
            },
            child: const Text('upload'),
          )
        ],
      ),
      body: GridView.builder(
          itemCount: _selectedFiles.length + 1,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      chooseImage();
                    },
                  ))
                : Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_selectedFiles[index - 1]),
                            fit: BoxFit.cover)),
                  );
          }),
    );
  }

  Future uploadFile() async {
    for (var img in _selectedFiles) {
      storage.Reference ref = storage.FirebaseStorage.instance
          .ref()
          .child('houses/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
        });
      });
    }
  }

  @override
  initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }

  chooseImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _selectedFiles.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _selectedFiles.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }
}
