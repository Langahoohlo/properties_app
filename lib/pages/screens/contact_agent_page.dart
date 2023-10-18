// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ContactAgentPage extends StatefulWidget {
  final String agentUsername;
  final String agentPhoneNumbers;
  final String agentWhatsApp;
  const ContactAgentPage(
      {super.key,
      required this.agentUsername,
      required this.agentPhoneNumbers,
      required this.agentWhatsApp});

  @override
  _ContactAgentPageState createState() => _ContactAgentPageState();
}

class _ContactAgentPageState extends State<ContactAgentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Coming soon",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // GestureDetector(
                //   onLongPress: () {
                //     Clipboard.setData(
                //         new ClipboardData(text: widget.agentPhoneNumbers));
                //     showSnackBar('Copied To Clipboard', context);
                //   },
                //   child: Text(
                //     widget.agentPhoneNumbers,
                //     style: TextStyle(
                //         fontSize: 22,
                //         fontWeight: FontWeight.normal,
                //         color: Colors.black),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   widget.agentWhatsApp,
                //   style: TextStyle(fontSize: 22),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
