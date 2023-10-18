// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:properties_app/model/house.dart';
import 'package:properties_app/pages/detail/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:properties_app/resources/firestore_methods.dart';

class RecommendedHouse extends StatefulWidget {
  const RecommendedHouse({super.key});

  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
  //const RecommendedHouse({Key key}) : super(key: key);
  final recommendedList = House.generateRecommended();

  var userData = {};
  int postLen = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('users').doc().get();

      //post numbers
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          //.where('likes', arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
      //showSnackBar(context, e.toString());
    }

    //   print(snap.data());

    //   setState(() {
    //     username = (snap.data() as Map<String, dynamic>)['username'];
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Recommended',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(1),
              height: 300,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('likes', descending: true)
                      .limit(10)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if ((snapshot.data! as dynamic).docs.isEmpty) {
                      return Center(
                        child: Text("No reccomendations yet"),
                      );
                    }
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        postId: snap['postId'],
                                      ))),
                          child: Container(
                              height: 300,
                              width: 230,
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snap['postUrl'],
                                        ),
                                        fit: BoxFit.cover),
                                  )),
                                  Positioned(
                                      right: 15,
                                      top: 15,
                                      child: IconButton(
                                          onPressed: () async {
                                            await FireStoreMethods().likePost(
                                                snap['postId'],
                                                snap['uid'],
                                                snap['likes']);
                                          },
                                          icon: snap['likes']
                                                  .contains(snap['uid'])
                                              ? const Icon(
                                                  Icons.bookmark_add,
                                                  color: Colors.deepPurple,
                                                  size: 32,
                                                )
                                              : const Icon(
                                                  Icons.bookmark_add_outlined,
                                                  size: 26,
                                                ))),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: Colors.white54,
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'M' + snap['price'],
                                                    //?? "Loading...",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(snap['houseLocation'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayLarge!
                                                          .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                ],
                                              ),
                                              // Icon(Icons.heart_broken,
                                              //     color: Colors.pink)
                                            ]),
                                      ))
                                ],
                              )),
                        );
                      }),
                      separatorBuilder: (_, index) => const SizedBox(
                        width: 20,
                      ),
                      itemCount: (snapshot.data! as dynamic).docs.length,
                    );
                  })),
        ],
      ),
    );
  }
}
