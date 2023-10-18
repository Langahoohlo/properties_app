//ignore_for_file: prefer_const_constructors
//import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:properties_app/pages/auth/auth_methods.dart';
import 'package:properties_app/pages/auth_pages/login_page.dart';
import 'package:properties_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import 'agent_registration.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  // final VoidCallback showLoginPage;
  // const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordControllerConfirm.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _passwordControllerConfirm.text.trim()) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Passwords do not match"),
            );
          });
      return false;
    }
  }

  void signUpUser() async {
    //passwordConfirmed();
    setState(() {
      _isLoading = true;
    });
    //if (!_formKey.currentState!.validate()) {
    //return;
    try {
      //String res =
      await AuthMethods().signUpUser(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumbers: _phoneNumberController.text.trim(),
        //file: _image!
      );
      //showSnackBar("Account succesfully created", context);
      // if (res != 'success') {
      //   showSnackBar(res, context);
      // }
    } on FirebaseAuthException catch (e) {
      AlertDialog(
        content: Text(e.toString()),
      );
      //print(e);
      //showSnackBar(e.toString(), context);
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         content: Text(e.message.toString()),
      //       );
      //     });
      //}
      setState(() {
        _isLoading = false;
      });
    }
    //print(res);
  }

  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 250.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgentRegistrationPage()),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.end,
                          'Agents Please Register Here',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      Icons.house_rounded,
                      size: 100,
                      color: Colors.black54,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    //image controller
                    // _image != null
                    //     ? GestureDetector(
                    //         onTap: selectImage,
                    //         child: CircleAvatar(
                    //           radius: 64,
                    //           backgroundImage: MemoryImage(_image!),
                    //         ),
                    //       )
                    //     : GestureDetector(
                    //         onTap: selectImage,
                    //         child: const CircleAvatar(
                    //           radius: 64,
                    //           backgroundImage: NetworkImage(
                    //               'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png'),
                    //         ),
                    //       ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Positioned(
                    //     bottom: -10,
                    //     left: 80,
                    //     child: IconButton(
                    //         onPressed: selectImage,
                    //         icon: const Icon(Icons.add_a_photo))),

                    // Text(
                    //   'Please Choose Profile Picture Above!',
                    //   style: TextStyle(fontSize: 12),
                    // ),
                    // SizedBox(height: 20),
                    Text(
                      'Please Fill All Fields To Register!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //emaill controller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              return null;
                            },
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Email'),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //username controller
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Container(
                    //       padding: EdgeInsets.only(left: 10),
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           border: Border.all(color: Colors.black),
                    //           borderRadius: BorderRadius.circular(20)),
                    //       child: TextFormField(
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return "Username cannot be empty";
                    //           }
                    //           return null;
                    //         },
                    //         controller: _usernameController,
                    //         decoration: InputDecoration(
                    //             border: InputBorder.none,
                    //             hintText: 'Please enter your username'),
                    //       )),
                    // ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // //phone numbers controller
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Container(
                    //       padding: EdgeInsets.only(left: 10),
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           border: Border.all(color: Colors.black),
                    //           borderRadius: BorderRadius.circular(20)),
                    //       child: TextFormField(
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return "Phone number cannot be empty";
                    //           }
                    //           return null;
                    //         },
                    //         controller: _phoneNumberController,
                    //         keyboardType: TextInputType.number,
                    //         decoration: InputDecoration(
                    //             border: InputBorder.none,
                    //             hintText: 'Please enter your Phone numbers'),
                    //       )),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      'Password must have more than 7 characters',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //confirm passwordcontroller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              } else if (value.length <= 7) {
                                return "Password must have more than 7 characters";
                              }
                              return null;
                            },
                            controller: _passwordController,
                            obscureText: _obsecurePassword,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        _obsecurePassword = !_obsecurePassword),
                                    icon: Icon(
                                      _obsecurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ))),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // confrim Password controller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password confirmation cannot be empty";
                              }
                              return null;
                            },
                            controller: _passwordControllerConfirm,
                            obscureText: _obsecureConfirmPassword,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        _obsecureConfirmPassword =
                                            !_obsecureConfirmPassword),
                                    icon: Icon(
                                      _obsecurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ))),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signUpUser,
                        //signUpUser,
                        // () {
                        //   if (_formKey.currentState!.validate()) {
                        //     signUpUser();
                        //   }
                        // },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 34, 33, 33),
                              borderRadius: BorderRadius.circular(12)),
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.purple,
                                ))
                              : Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      //onTap: widget.showLoginPage,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account?',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            'Click here',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
