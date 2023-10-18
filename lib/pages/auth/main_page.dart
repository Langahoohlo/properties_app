import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:properties_app/widget/pages/login_page.dart';

import '../home_page.dart';
import '../auth_pages/login_page.dart';

//package:properties_app/widget/pages/main_page.dart

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomePage();
              } else if (snapshot.hasError) {
                //return AuthPage();
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return const LoginPage();
              }
            }
            return const LoginPage();
          }),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: StreamBuilder(
  //         stream: FirebaseAuth.instance.authStateChanges(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.active) {
  //             if (snapshot.hasData) {
  //               return const HomePage();
  //             } else if (snapshot.hasError) {
  //               //return AuthPage();
  //               return Center(
  //                 child: Text('${snapshot.error}'),
  //               );
  //             } else {
  //               return const AuthPage();
  //             }
  //           }
  //           return const AuthPage();
  //         }),
  //   );
  // }
}
