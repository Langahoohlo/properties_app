import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);
  //List<XFile> _file = [];

  if (file != null) {
    return await file.readAsBytes();
  }
  print('No image selcted');

  // Future<void> selectImage() async {
  //   if (_file != null) {
  //     _file.clear();
  //   }
  //   try {
  //     final List<XFile>? imgs = await _imagePicker.pickMultiImage();
  //     if (imgs!.isNotEmpty) {
  //       _file.addAll(imgs);
  //     }
  //     print("List of selected Images" + imgs.length.toString());
  //   } catch (e) {
  //     print('Something went wrong.' + e.toString());
  //   }
  // }

  //setState(() {});
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        item,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    ));
