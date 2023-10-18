import 'package:flutter/material.dart';
import 'package:properties_app/responsive/web_layout.dart';
import 'package:properties_app/utils/dimensions.dart';

import 'mobile_layout.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileLayout,
    required this.webLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return const WebLayout();
      } else {
        return const MobileLayout();
      }
    });
  }
}
