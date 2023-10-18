import 'package:flutter/material.dart';

class TopRecommended extends StatefulWidget {
  const TopRecommended({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TopRecommended();
}

class _TopRecommended extends State<TopRecommended> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Top Recomended Page'),
    );
  }
}
