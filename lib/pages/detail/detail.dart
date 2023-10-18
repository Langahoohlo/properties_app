// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:properties_app/pages/detail/widget/about.dart';
import 'package:properties_app/pages/detail/widget/content_intro.dart';
import 'package:properties_app/pages/detail/widget/detail_app_bar.dart';
import 'package:properties_app/pages/detail/widget/house_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:properties_app/pages/screens/contact_agent_page.dart';
import 'package:properties_app/utils/dimensions.dart';
import 'package:properties_app/utils/utils.dart';

class DetailPage extends StatefulWidget {
  final String postId;
  // final String postUrl;
  // final String username;
  // final String price;
  // final String bedrooms;
  // final String bathrooms;
  // final String garages;
  const DetailPage({
    Key? key,
    required this.postId,
    //required uid,
    // required this.postUrl,
    // required this.username,
    // required this.price,
    // required this.bedrooms,
    // required this.bathrooms,
    // required this.garages
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var userPost = {};
  var userData = {};

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get();

      // var postSnap = await FirebaseFirestore.instance
      //     .collection('users')
      //     .where('widget.postId', arrayContains: widget.postId)
      //     .get();

      userPost = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance.collection('posts').snapshots(),
    //     builder: (context,
    //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    //       return Builder(builder: (context) {
    //         DocumentSnapshot snap = (snapshot.data! as dynamic).docs[context];
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5)
            : EdgeInsets.all(0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailAppBar(postId: userPost['postId'] ?? "Not available"),
            const SizedBox(height: 20),
            ContentIntro(
              aboutHouse: userPost['aboutHouse'] ?? "Not available",
              price: userPost['price'] ?? "0",
              houseLocation: userPost['houseLocation'] ?? "Not available",
              rentOrSale: userPost['forSaleOrForRent'] ?? "Not available",
            ),
            const SizedBox(height: 20),
            HouseInfo(
              bathroom: userPost['bathrooms'] ?? "0",
              bedroom: userPost['bedrooms'] ?? "0",
              garages: userPost['garages'] ?? "0",
            ),
            const SizedBox(height: 20),
            About(
              about: userPost['houseName'] ?? "0",
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('District: ${userPost['district'] ?? "Not available"}',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 20),
                    Text(
                        'Rent or Sale: ${userPost['forSaleOrForRent'] ?? "Not available"}',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 20),
                    Text(
                        'Date Available: ${userPost['dateAvailable'] ?? "Loading..."}',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Agent Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                          userPost['profImage'] ??
                              "https://images.unsplash.com/flagged/photo-1593005510509-d05b264f1c9c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userPost['username'] ?? "Not available",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                text:
                                    userPost['phoneNumbers'] ?? "Not available",
                              ));
                              showSnackBar('Copied To Clipboard', context);
                            },
                            child: Icon(Icons.copy)),
                        // Text(
                        //   ' ${userPost['agentPhoneNumbers'] ?? "Loading"}',
                        //   style: TextStyle(fontSize: 22),
                        // ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GestureDetector(
                    //         onTap: () {
                    //           Clipboard.setData(ClipboardData(
                    //             text: userPost['agentWhatsApp'],
                    //           ));
                    //           showSnackBar('Copied To Clipboard', context);
                    //         },
                    //         child: Icon(Icons.copy)),
                    //     Text(
                    //       ' ${userPost['agentWhatsApp'] ?? "Loading"}',
                    //       style: TextStyle(fontSize: 22),
                    //     ),
                    //   ],
                    // ),
                  ]),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactAgentPage(
                          agentPhoneNumbers:
                              userPost['agentPhoneNumbers'] ?? "Loading",
                          agentUsername: userPost['agentName'] ?? "Loading",
                          agentWhatsApp:
                              userPost['agentWhatsApp'] ?? "Loading")));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  //decoration: BoxDecoration(),
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
  //);
}
        //);
  //}
//}
