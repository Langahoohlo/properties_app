// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:properties_app/utils/utils.dart';

class UploadMultipleImages extends StatefulWidget {
  const UploadMultipleImages({Key? key}) : super(key: key);

  @override
  _UploadMultipleImageState createState() => _UploadMultipleImageState();
}

class _UploadMultipleImageState extends State<UploadMultipleImages> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedFiles = [];
  final FirebaseStorage _storageRef = FirebaseStorage.instance;
  final List<String> _arrImageUrls = [];
  int uploadItem = 0;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        child: Center(
          child: _isUploading
              ? showLoading()
              : Column(
                  children: [
                    SizedBox(height: 75),
                    OutlinedButton(
                        onPressed: () {
                          selectImage();
                        },
                        child: Text('Select Pictures')),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (_selectedFiles.isNotEmpty) {
                            uploadFunction(_selectedFiles);
                          } else {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text('Please select some images')));
                            showSnackBar('Please select some images.', context);
                          }
                        },
                        icon: Icon(Icons.file_upload),
                        label: Text("Upload")),
                    _selectedFiles.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Text('No images Selected'),
                          )
                        : Expanded(
                            child: GridView.builder(
                                itemCount: _selectedFiles.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.file(
                                      File(_selectedFiles[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }),
                          )
                    //Text('Images selected : ' + _selectedFiles.length.toString())
                  ],
                ),
        ),
      )),
    );
  }

  Widget showLoading() {
    return Center(
      child: Column(children: [
        Text("Uploading : " +
            uploadItem.toString() +
            "/" +
            _selectedFiles.length.toString()),
        SizedBox(
          height: 30,
        ),
        LinearProgressIndicator()
      ]),
    );
  }

  void uploadFunction(List<XFile> images) {
    setState(() {
      _isUploading = true;
    });
    for (int i = 0; i < images.length; i++) {
      var imageUrl = uploadFile(images[i]);
      _arrImageUrls.add(imageUrl.toString());
    }
  }

  // Future<String> uploadFile(XFile _image) async {
  //   Reference reference = _storageRef.ref("testing").child(_image.name);
  //   UploadTask uploadTask = reference.putFile(File(_image.path));
  //   await uploadTask.whenComplete(() {
  //     setState(() {
  //       uploadItem++;
  //       if (uploadItem == _selectedFiles.length) {
  //         _isUploading = false;
  //         uploadItem = 0;
  //       }
  //     });
  //   });
  //   return await reference.getDownloadURL();
  // }

  Future<String> uploadFile(XFile image) async {
    Reference reference = _storageRef.ref("testing").child(image.name);
    UploadTask uploadTask = reference.putFile(File(image.path));
    await uploadTask.whenComplete(() {
      setState(() {
        uploadItem++;
        if (uploadItem == _selectedFiles.length) {
          _isUploading = false;
          uploadItem = 0;
        }
      });
    });
    return await reference.getDownloadURL();
  }

  Future<void> selectImage() async {
    _selectedFiles.clear();
    try {
      final List<XFile> imgs = await _picker.pickMultiImage();
      if (imgs.isNotEmpty) {
        _selectedFiles.addAll(imgs);
      }
      print("List of selected iamges: " + imgs.length.toString());
    } catch (e) {
      print("Something went wrong" + e.toString());
    }
    setState(() {});
  }
}
