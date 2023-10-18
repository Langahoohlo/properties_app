// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:properties_app/pages/detail/detail.dart';
// import 'package:intl/intl_browser.dart';
// import 'package:intl/date_symbol_data_local.dart';
//findSystemLocale().then(runTheRestOfMyProgram);

class UserPostCard extends StatelessWidget {
  final snap;
  const UserPostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        postId: snap['postId'],
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
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                              'M${snap['price']} : ${snap['forSaleOrForRent']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text.rich(TextSpan(children: [
                            //TextSpan(text: ''),
                            WidgetSpan(
                                child: Icon(Icons.bedroom_parent,
                                    color: Colors.black)),
                            TextSpan(text: snap['bedrooms']),
                          ])),
                          Text.rich(TextSpan(children: [
                            //TextSpan(text: ''),
                            WidgetSpan(
                              child: Icon(
                                Icons.bathroom,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(text: snap['bathrooms']),
                          ])),
                          Text.rich(TextSpan(children: [
                            //TextSpan(text: ''),
                            WidgetSpan(
                                child: Icon(Icons.garage, color: Colors.black)),
                            TextSpan(text: snap['garages']),
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
                                    text: '${snap['houseLocation']}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                          Spacer(),
                          Text('${snap['likes'].length} likes',
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
