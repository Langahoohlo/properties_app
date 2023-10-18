// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgencyLogo extends StatelessWidget {
  const AgencyLogo({super.key});

  // final snap;
  // const AgencyLogo({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://scontent.fmsu1-2.fna.fbcdn.net/v/t39.30808-6/307840369_477176084420289_7792985350416161093_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGXBaEZE2OXuRvXeHydfMbrxU9xg2Kd-4vFT3GDYp37ixKEkiAjPMF10eJLViBTBz00wlPmKjqRXMM35-v3qv8g&_nc_ohc=21pRN33MkQ0AX-ugb4W&_nc_ht=scontent.fmsu1-2.fna&oh=00_AfBy6eS3CETQOxY4uwCRMkG38fHqQCcFgN-wxBUz2MTbQQ&oe=63E714D6',
                ))));
  }
}
