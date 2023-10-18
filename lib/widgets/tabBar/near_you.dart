//stateful widget for near you
import 'package:flutter/material.dart';

class NearYou extends StatefulWidget {
  const NearYou({super.key});

  @override
  _NearYouState createState() => _NearYouState();
}

//state for near you
class _NearYouState extends State<NearYou> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('Near You')),
    );
  }
}
