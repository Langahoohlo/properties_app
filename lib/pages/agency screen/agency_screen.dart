// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:properties_app/pages/agency%20screen/agency_logo.dart';

class AgencyDetails extends StatefulWidget {
  final String agencyName;

  const AgencyDetails({super.key, required this.agencyName});

  @override
  State<AgencyDetails> createState() => _AgencyDetailState();
}

class _AgencyDetailState extends State<AgencyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: const [AgencyLogo()]),
    ));
  }
}
