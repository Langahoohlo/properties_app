import 'package:flutter/material.dart';

//create as tateless widget
class ArrangeBy extends StatelessWidget {
  const ArrangeBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            height: 60,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 35,
                  width: 110,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey),
                  child: const Center(
                      child:
                          Text('Rent Or Sale', style: TextStyle(fontSize: 18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 35,
                  width: 95,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: const Center(
                      child: Text('District', style: TextStyle(fontSize: 18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: const Center(
                      child: Text('Property Type',
                          style: TextStyle(fontSize: 18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: const Center(
                      child:
                          Text('Price Range', style: TextStyle(fontSize: 18))),
                ),
              ),
            ]),
          ),
        ]));
  }
}
