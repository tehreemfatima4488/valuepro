import 'package:flutter/material.dart';
import 'package:valuepro/ResponsiveLayout/desktop_view.dart';
import 'package:valuepro/ResponsiveLayout/mobile_view.dart';
import 'package:valuepro/ResponsiveLayout/responsive_layout.dart';

import 'Screens/auth/LoginScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
    // return ResponsiveLayout(mobileView: MobileView(), desktopView: DesktopView());

  }
}
