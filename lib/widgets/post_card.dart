// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:properties_app/pages/detail/detail.dart';
import 'package:properties_app/resources/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl_browser.dart';
// import 'package:intl/date_symbol_data_local.dart';
//findSystemLocale().then(runTheRestOfMyProgram);

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var userData = {};
  var postData = {};

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      setState(() {
        userData = userSnap.docs.first.data();
        postData = postSnap.docs.first.data();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //alignment: Alignment.center,
            margin: const EdgeInsets.all(1),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              //border: Border.all(color: Colors.black, width: 3),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(
                        postId: widget.snap['postId'],
                      ))),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(widget.snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 15,
                          top: 15,
                          child: IconButton(
                              onPressed: () async {
                                await FireStoreMethods().likePost(
                                    widget.snap['postId'],
                                    FirebaseAuth.instance.currentUser!.uid,
                                    widget.snap['likes']);
                              },
                              icon: widget.snap['likes'].contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? const Icon(
                                      Icons.bookmark_add,
                                      color: Colors.deepPurple,
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.bookmark_add_outlined,
                                      size: 26,
                                    )))
                    ],
                  ),
                  SizedBox(
                      height:
                          4.0), // Add some space between the image and the text
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          // Text(
                          //     textAlign: TextAlign.left,
                          //     'M${widget.snap['datePublished']} ',
                          //     style:
                          //         const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              textAlign: TextAlign.left,
                              'M${widget.snap['price']} : ${widget.snap['forSaleOrForRent']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text.rich(TextSpan(children: [
                            //TextSpan(text: ''),
                            WidgetSpan(
                                child: Icon(Icons.bedroom_parent,
                                    color: Colors.black)),
                            TextSpan(text: widget.snap['bedrooms']),
                          ])),
                          Text.rich(TextSpan(children: [
                            //TextSpan(text: ''),
                            WidgetSpan(
                              child: Icon(
                                Icons.bathroom,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(text: widget.snap['bathrooms']),
                          ])),
                          Text.rich(TextSpan(children: [
                            //TextSpan(text: ''),
                            WidgetSpan(
                                child: Icon(Icons.garage, color: Colors.black)),
                            TextSpan(text: widget.snap['garages']),
                          ])),
                        ],
                      ),
                      //SizedBox(height: 2),
                      Row(
                        children: [
                          RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: '${widget.snap['houseLocation']}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                          Spacer(),
                          Text('${widget.snap['likes'].length} likes',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //),
    );
  }
}
