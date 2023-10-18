//ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:properties_app/pages/auth/auth_methods_agent.dart';
import 'package:properties_app/pages/auth_pages/login_page.dart';
import 'package:properties_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgentRegistrationPage extends StatefulWidget {
  const AgentRegistrationPage({super.key});

  // final VoidCallback showLoginPage;
  // const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<AgentRegistrationPage> createState() => _AgentRegistrationPageState();
}

class _AgentRegistrationPageState extends State<AgentRegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _agency = TextEditingController();
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
    _bioController.dispose();
    _agency.dispose();
    super.dispose();
  }

  var userData = {};

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('agencies')
          .doc('agencyName')
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
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
    try {
      //String res =
      await AuthMethodsAgent().signUpAgent(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumbers: _phoneNumberController.text.trim(),
        file: _image!,
        agency: _agency.text.trim(),
      );
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
    }
    setState(() {
      _isLoading = false;
    });

    //print(res);
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          item,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ));

  String? agencies;

  final nameOfAgencies = ['Smart Life', 'Bee Properties', 'Take it ls'];
  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox(height: 10),
                    // Icon(
                    //   Icons.house_rounded,
                    //   size: 100,
                    //   color: Colors.black54,
                    // ),
                    SizedBox(height: 20),
                    //image controller
                    _image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png'),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Please Upload A Picture of Yourself',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 20),
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
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username cannot be empty";
                              }
                              return null;
                            },
                            controller: _usernameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Please enter your username'),
                          )),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //phone numbers controller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone number cannot be empty";
                              }
                              return null;
                            },
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Please enter your Phone numbers'),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 35,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.black,
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          focusColor: Colors.black,
                          isExpanded: true,
                          value: agencies,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Agency',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          items: nameOfAgencies.map(buildMenuItem).toList(),
                          onChanged: (value) =>
                              setState(() => agencies = value),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //bio controller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            minLines: 5,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Bio cannot be empty";
                              }
                              return null;
                            },
                            controller: _bioController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    'About Agent, Please enter any informtion so clients can know you'),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
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
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
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
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signUpUser();
                          }
                        },
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
