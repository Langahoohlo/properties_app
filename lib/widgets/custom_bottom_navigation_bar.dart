import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final bottomBarItem = [
    const Icon(Icons.home, color: Colors.deepPurple),
    const Icon(Icons.search, color: Colors.deepPurple),
    const Icon(Icons.notifications, color: Colors.deepPurple),
    const Icon(Icons.chat, color: Colors.deepPurple),
    const Icon(Icons.local_offer, color: Colors.deepPurple)
  ];

  CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomBarItem,

          // .map((e) =>
          //     Icon(Icons.home, color: Theme.of(context).primaryColor))
          // .toList(),
        ));
  }
}
