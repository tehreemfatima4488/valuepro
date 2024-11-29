import 'package:flutter/material.dart';
import '../Constants/app_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileView;
  final Widget desktopView;

  const ResponsiveLayout(
      {required this.mobileView, required this.desktopView, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > AppConstants.mobileWidth) {
        return desktopView;
      } else {
        return mobileView;
      }
    });
  }
}
