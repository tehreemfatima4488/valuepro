import 'package:flutter/material.dart';
import 'package:valuepro/ResponsiveLayout/responsive_layout.dart';
import 'package:valuepro/Screens/dashboard/desktopDashboard.dart';
import 'package:valuepro/Screens/dashboard/mobileDashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileView: MobileDashboard(), desktopView: DesktopDashboard());
  }
}
