// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:properties_app/utils/utils.dart';
import '../../resources/firestore_methods.dart';

//create a stateful widget
class EditProfile extends StatefulWidget {
  final String uid;
  final String username;
  const EditProfile({Key? key, required this.uid, required this.username})
      : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

//create a state class
class _EditProfileState extends State<EditProfile> {
  //create a firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a form key
  final _formKey = GlobalKey<FormState>();

  //create a text editing controller
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  //TextEditingController _bioController = TextEditingController();

  //create a firestore instance
  var userData = {};
  int postLen = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //post numbers
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
      //showSnackBar(context, e.toString());
    }

    //   print(snap.data());

    //   setState(() {
    //     username = (snap.data() as Map<String, dynamic>)['username'];
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Edit Profile"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
              //replace with our own icon data.
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(userData['photoUrl'] ??
                            "https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1129&q=80"),
                        radius: 60,
                      ),
                      Positioned(
                        bottom: 2,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 22,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Create a text field
                  Text(userData['email']),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: userData['username'] ?? 'username',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         border: Border.all(color: Colors.black54),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextFormField(
                  //       controller: _phoneNumberController,
                  //       decoration: InputDecoration(
                  //         hintText: userData['phoneNumbers'] ?? 'phone number',
                  //         border: InputBorder.none,
                  //       ),
                  //       validator: (value) {
                  //         if (value!.isEmpty) {
                  //           return "Phone Number cannot be empty";
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         border: Border.all(color: Colors.black54),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextFormField(
                  //       controller: _phoneNumberController,
                  //       decoration: InputDecoration(
                  //         hintText: "Password",
                  //         border: InputBorder.none,
                  //       ),
                  //       validator: (value) {
                  //         if (value!.isEmpty) {
                  //           return "Phone Number cannot be empty";
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         border: Border.all(color: Colors.black54),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextFormField(
                  //       controller: _phoneNumberController,
                  //       decoration: InputDecoration(
                  //         hintText: "Phone Number",
                  //         border: InputBorder.none,
                  //       ),
                  //       validator: (value) {
                  //         if (value!.isEmpty) {
                  //           return "Phone Number cannot be empty";
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // // TextFormField(
                  // //   controller: _bioController,
                  // //   decoration: InputDecoration(
                  // //     hintText: "Bio",
                  // //   ),
                  // //   validator: (value) {
                  // //     if (value!.isEmpty) {
                  // //       return "Bio cannot be empty";
                  // //     }
                  // //     return null;
                  // //   },
                  // // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //update the user details
                        FireStoreMethods().updateUsername(
                            userData['uid'], userData['username'], {
                          'username': _usernameController.text,
                          //'phoneNumbers': _phoneNumberController.text,
                          // 'username': 'New username',
                          // 'phoneNumbers': 'New phoneNumbers',
                        }).whenComplete(
                            () => showSnackBar('The method is done', context));
                      }
                    },
                    child: Text("Update Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ),
                  Text(
                    'Delete Profile',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  //create a bool variable to check if the user is
}
