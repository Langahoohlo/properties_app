// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:properties_app/pages/bottomNavPages/home.dart';
import 'package:properties_app/profile_screens/user_account.dart';
import 'package:properties_app/widgets/google_sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool isPaidUser = false;
  final user = FirebaseAuth.instance.currentUser!;

  CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final googleUser = Provider.of<GoogleSignInProvider>(context);
    //final User user = Provider.of<UserProvider>(context).getUser;
    return SafeArea(
      //child: Container(
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => (UserAccount(uid: user)))));
                },
                child: Icon(
                  color: Colors.black,
                  Icons.house_rounded,
                  size: 40,
                  //backgroundColor: null,
                  // backgroundImage: NetworkImage(
                  //     'https://images.unsplash.com/photo-1592595896551-12b371d546d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                  //radius: 20,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/PROJECT_BEE_HIVE.svg',
                //'assets/svg/MATLO_LESOTHO.svg',
                width: 10,
                height: 20,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => (UserHome(
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              )))));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.providerData.first.providerId == 'google.com'
                        ? user.photoURL ??
                            'https://i.pinimg.com/originals/3f/94/70/3f9470b34a8e3f526dbdb022f9f19cf7.jpg'
                        : 'https://i.pinimg.com/originals/3f/94/70/3f9470b34a8e3f526dbdb022f9f19cf7.jpg',
                  ),
                  backgroundColor: Colors.black,
                  // child: IconButton(
                  //   color: Colors.white,
                  //   onPressed: () async {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: ((context) => (UserHome(
                  //                   uid: FirebaseAuth.instance.currentUser!.uid,
                  //                 )))));
                  //   },
                  //   icon: Icon(Icons.account_circle),
                  // ),
                ),
              ),

              // IconButton(
              //   color: Colors.black,
              //   onPressed: () async {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: ((context) => (UserHome(
              //                   uid: FirebaseAuth.instance.currentUser!.uid,
              //                 )))));
              //   },
              //   icon: Icon(Icons.account_circle),
              // ),

              // IconButton(
              //   color: Colors.black,
              //   onPressed: () async {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: ((context) => (UploadScreen()))));
              //   },
              //   icon: Icon(Icons.upload_sharp),
              // )
            ],
          )),
    );
  }

  @override
  // ignore: todo
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
