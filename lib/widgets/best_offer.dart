// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: prefer_const_constructors
import '../../../model/house.dart';

class BestOffer extends StatefulWidget {
  const BestOffer({super.key});

  @override
  State<BestOffer> createState() => _BestOfferState();
}

class _BestOfferState extends State<BestOffer> {
  final listOfOffer = House.generateBestOffer();

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
          //.where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //Builder: ((context, index)=> GestureDetector(onTap: (){},))
          children: [
            Text(
              'Best Offer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            //   style: Theme.of(context)
            //       .textTheme
            //       .headline1!
            //       .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            Text(
              'See All',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              // style: Theme.of(context)
              //     .textTheme
              //     .bodyText1!
              //     .copyWith(fontSize: 14, fontWeight: FontWeight.bold)
            ),
          ],
        ),
        // Container(
        //     margin: EdgeInsets.only(bottom: 10),
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //         color: Colors.white, borderRadius: BorderRadius.circular(8)),
        //     child: FutureBuilder(
        //       future: FirebaseFirestore.instance
        //           .collection('posts')
        //           //.where('likes', isGreaterThan: 0)
        //           .get(),
        //       builder: ((context, snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         }
        //         return ListView.builder(
        //             itemCount: (snapshot.data! as dynamic).docs.length,
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: ((context, index) {
        //               DocumentSnapshot snap =
        //                   (snapshot.data! as dynamic).docs[index];
        //               return Row(
        //                 children: [
        //                   Container(
        //                     //onPressed:()async{},
        //                     width: 150,
        //                     height: 80,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage(
        //                               snap['postUrl'],
        //                             ),
        //                             fit: BoxFit.cover),
        //                         borderRadius: BorderRadius.circular(8)),
        //                   ),
        //                   const SizedBox(width: 10),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         'el.houseName',
        //                         style: TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.bold),
        //                         // style: Theme.of(context)
        //                         //     .textTheme
        //                         //     .headline1!
        //                         //     .copyWith(
        //                         //       fontSize: 16,
        //                         //       fontWeight: FontWeight.bold,
        //                         //     ),
        //                       ),
        //                       const SizedBox(
        //                         height: 10,
        //                       ),
        //                       Text(
        //                         'el.address',
        //                         style: TextStyle(
        //                             fontSize: 12,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.grey),
        //                         // Theme.of(context)
        //                         //     .textTheme
        //                         //     .bodyText1!
        //                         //     .copyWith(
        //                         //       fontSize: 12,
        //                         //     ),
        //                       )
        //                     ],
        //                   )
        //                 ],
        //               );
        //             }));
        //       }),
        //     )),

        const SizedBox(height: 10),
        ...listOfOffer
            .map((el) => GestureDetector(
                  onTap: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   DetailPage(
                    //     house: listOfOffer[0],
                    //   );
                    //   return DetailPage(house: listOfOffer[0]);
                    // }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "Coming soon",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Row(
                            children: [
                              Container(
                                //onPressed:()async{},
                                width: 150,
                                height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(el.imageUrl),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    el.houseName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .headline1!
                                    //     .copyWith(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    el.address,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    // Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText1!
                                    //     .copyWith(
                                    //       fontSize: 12,
                                    //     ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Icon(Icons.health_and_safety_rounded,
                              color: Colors.purple),
                        )
                      ],
                    ),
                  ),
                ))
            .toList()
      ]),
    );
  }
}
