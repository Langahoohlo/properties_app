//create stateful widget for agency recomended
import 'package:flutter/material.dart';

//create state for agency recomended
class AgencyRecomended extends StatefulWidget {
  const AgencyRecomended({super.key});

  @override
  _AgencyRecomendedState createState() => _AgencyRecomendedState();
}

//create state for agency recomended
class _AgencyRecomendedState extends State<AgencyRecomended> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('Agency Recomended')),
    );
  }
}
