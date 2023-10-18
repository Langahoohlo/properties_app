//create stateful widget for most popular
import 'package:flutter/material.dart';

//create stateful widget for most popular
class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  _MostPopularState createState() => _MostPopularState();
}

//create state for most popular
class _MostPopularState extends State<MostPopular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('Most Popular')),
    );
  }
}
