import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:properties_app/pages/auth/auth_methods_agency.dart';
import 'package:properties_app/utils/utils.dart';

//create a stateful widget
class RegisterAgency extends StatefulWidget {
  const RegisterAgency({Key? key}) : super(key: key);

  @override
  _RegisterAgencyState createState() => _RegisterAgencyState();
}

class _RegisterAgencyState extends State<RegisterAgency> {
  final TextEditingController _agencyName = TextEditingController();
  final TextEditingController _agencyEmail = TextEditingController();
  final TextEditingController _agencyPhoneNumbers = TextEditingController();
  final TextEditingController _agencyBio = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm =
      TextEditingController();

  Uint8List? _image;
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //create a void dispose
  @override
  void dispose() {
    _agencyName.dispose();
    _agencyEmail.dispose();
    _agencyPhoneNumbers.dispose();
    _agencyBio.dispose();
    _passwordController.dispose();
    _passwordControllerConfirm.dispose();
    _fullName.dispose();
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
            return const AlertDialog(
              content: Text("Passwords do not match"),
            );
          });
      return false;
    }
  }

  void signUpAgency() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate() && passwordConfirmed()) {
      try {
        await AuthMethodsAgency().signUpAgency(
            agencyEmail: _agencyEmail.text.trim(),
            agencyName: _agencyName.text.trim(),
            password: _passwordController.text.trim(),
            phoneNumbers: _agencyPhoneNumbers.text.trim(),
            agencyBio: _agencyBio.text.trim(),
            file: _image!,
            agencyOwner: _fullName.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          const AlertDialog(
            content: Text('The password provided is too weak.'),
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          const AlertDialog(
            content: Text('The account already exists for that email.'),
          );
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
            child: Column(
          children: [
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
            const SizedBox(height: 20),
            const Text(
              "Register Agency",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _agencyName,
              decoration: const InputDecoration(
                hintText: "Agency Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your agency name";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _agencyEmail,
              decoration: const InputDecoration(
                hintText: "Agency Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your agency email";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _agencyPhoneNumbers,
              decoration: const InputDecoration(
                hintText: "Agency Phone Numbers",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your agency phone numbers";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _fullName,
              decoration: const InputDecoration(
                hintText: "Full names",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your agency phone numbers";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _agencyBio,
              decoration: const InputDecoration(
                hintText: "Agency Bio",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your agency bio";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordControllerConfirm,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                signUpAgency;
              },
              child: const Text("Sign Up"),
            ),
          ],
        )),
      ),
    ));
  }
}
