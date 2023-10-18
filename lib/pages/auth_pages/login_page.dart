//import 'dart:html';
//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:properties_app/pages/auth_pages/forgot_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:properties_app/pages/auth_pages/register_agency.dart';
import 'package:properties_app/pages/auth_pages/register_page.dart';
import 'package:properties_app/utils/dimensions.dart';
import 'package:properties_app/widgets/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // final VoidCallback showRegisterPage;
  // const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  bool _obsecurePassword = true;

  Future signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: MediaQuery.of(context).size.width > webScreenSize
                    ? EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3)
                    : EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SizedBox(height: 75),
                      // Container(
                      //   height: 300,
                      //   width: 500,
                      //   decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey,
                      //           blurRadius: 4,
                      //           offset: Offset(1, 8), // Shadow position
                      //         ),
                      //       ],
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(20),
                      //           bottomLeft: Radius.circular(20)),
                      //       image: DecorationImage(
                      //           image: AssetImage('assets/images/luxury.jpg'),
                      //           // NetworkImage(
                      //           //     'https://cdn.dribbble.com/userupload/2848083/file/original-4166eced8ca57c3d5e3b6d83d2e97abf.png?compress=1&resize=1024x768'),
                      //           //image: AssetImage('assets/images/house1.jpg'),
                      //           fit: BoxFit.cover)
                      //       // boxShadow: [
                      //       //   BoxShadow(
                      //       //       color: Colors.grey[300]!,
                      //       //       offset: Offset(0, 5),
                      //       //       blurRadius: 10)]
                      //       ),
                      //   //child: Image(image: AssetImage('assets/images/house1.jpg'))
                      // ),
                      // SizedBox(height: 10),
                      // SvgPicture.asset(
                      //   'assets/svg/PROJECT_BEE_HIVE.svg',
                      //   color: Colors.amber[900],
                      // ),
                      // Icon(
                      //   Icons.house_rounded,
                      //   size: 100,
                      //   color: Colors.black54,
                      // ),
                      // SizedBox(height: 10),
                      // Text(
                      //   'Hello Again',
                      //   style:
                      //       TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Welcome to'.toUpperCase(),
                      //   //'Welcome back you\'ve been missed!',
                      //   style:
                      //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(
                        height: 100,
                      ),
                      SvgPicture.asset(
                        'assets/svg/PROJECT_BEE_HIVE.svg',
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username cannot be empty";
                                }
                                return null;
                              },
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Please enter your email';
                              //   }
                              //   if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              //       .hasMatch(value)) {
                              //     return 'Please enter a valid email';
                              //   }
                              //   return null;
                              // },
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obsecurePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                      onPressed: () => setState(() =>
                                          _obsecurePassword =
                                              !_obsecurePassword),
                                      icon: Icon(
                                        _obsecurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ))),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          //signIn,

                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 34, 33, 33),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.purple,
                                    ))
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      GoogleBtn1(
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                        },
                        //onTap: widget.showRegisterPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Not a member?',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              'Register Here',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterAgency()));
                        },
                        //onTap: widget.showRegisterPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Admins',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              'Register Here',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
