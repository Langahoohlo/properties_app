import 'package:flutter/material.dart';
import 'package:properties_app/widgets/custom_app_bar.dart';
import 'package:properties_app/profile_screens/user_account/user_post_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//This is the feed screen about houses... UserProfile was a mistake
class UserPostCardView extends StatelessWidget {
  const UserPostCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: CustomAppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => UserPostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ));
  }
}
