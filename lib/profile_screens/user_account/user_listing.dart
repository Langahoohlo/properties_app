// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:properties_app/profile_screens/user_account/user_post_card.dart';

class UserListings extends StatelessWidget {
  // final uid;
  // UserListings({super.key, required this.uid});

  final user = FirebaseAuth.instance.currentUser!;

  UserListings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            //.where('uid', isEqualTo: user)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if ((snapshot.data! as dynamic).docs.isEmpty) {
            return Center(
              child: Text("You Don't Have Any\n Available Listing"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => UserPostCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
