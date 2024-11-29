import 'package:flutter/material.dart';
import 'package:valuepro/ResponsiveLayout/responsive_layout.dart';
import 'package:valuepro/Screens/BuildingEstimator/desktop_building_estimator.dart';
import 'package:valuepro/Screens/BuildingEstimator/mobile_building_estimator.dart';

class BuildingEstimator extends StatefulWidget {
  const BuildingEstimator({super.key});

  @override
  State<BuildingEstimator> createState() => _BuildingEstimatorState();
}

class _BuildingEstimatorState extends State<BuildingEstimator> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileView: MobileBuildingEstimator(), desktopView: DesktopBuildingEstimator());
  }
}
