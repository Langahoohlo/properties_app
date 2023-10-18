// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HouseInfo extends StatefulWidget {
  final String bedroom;
  final String bathroom;
  final String garages;
  //final String kitchen;

  const HouseInfo({
    Key? key,
    required this.bedroom,
    required this.bathroom,
    required this.garages,
  }) : super(key: key);

  @override
  State<HouseInfo> createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                MenuInfo(
                  icon: Icon(Icons.bedroom_parent),
                  content: '${widget.bedroom} bedroom',
                ),
                MenuInfo(
                  icon: Icon(Icons.bathroom),
                  content: '${widget.bathroom} bathroom',
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                // MenuInfo(
                //   icon: Icon(Icons.kitchen),
                //   content: '1 kitchen\n50 square meters',
                // ),
                MenuInfo(
                  icon: Icon(Icons.garage),
                  content: '${widget.garages} Garages',
                )
              ],
            ),
          ],
        ));
  }
}

class MenuInfo extends StatelessWidget {
  final String content;
  final Icon icon;
  const MenuInfo({Key? key, required this.content, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      child: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    ));
  }
}
