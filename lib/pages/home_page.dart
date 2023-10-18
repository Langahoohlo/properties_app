// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:properties_app/pages/bottomNavPages/profile.dart';
import 'package:properties_app/pages/bottomNavPages/search.dart';
import 'package:properties_app/utils/dimensions.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  int _selctedIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selctedIndex = index;
    });
  }

  //Swithching between pages(note UserHome is UserProfile)
  final List<Widget> _children = [
    UserProfile(),
    UserSearch(),
    //SearchScreen(),
    // UserNotifications(
    //   uid: FirebaseAuth.instance.currentUser!.uid,
    // ),
    //MultiImage(),
    //UserChat(),
    // UserHome(
    //   uid: FirebaseAuth.instance.currentUser!.uid,
    //),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > webScreenSize
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 5)
          : EdgeInsets.all(0),
      child: Scaffold(
        body: _children[_selctedIndex],
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.blueGrey,
          currentIndex: _selctedIndex,
          onTap: _navigateBottomNavBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  /*color: _selctedIndex == 0 ? Colors.black : Colors.blue*/
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.notifications), label: 'Notifications'),
            // BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.account_box_rounded), label: 'Account'),
          ],
        ),
      ),
    );
  }
}
