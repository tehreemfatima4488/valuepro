import 'package:flutter/material.dart';
import 'package:valuepro/Screens/BuildingEstimator/building_estimator.dart';

class DesktopDashboard extends StatefulWidget {
  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.pink,
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ValuePro AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    _buildFeatureItem(
                      title: 'Building Cost Estimator',
                      icon: Icons.attach_money,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BuildingEstimator()));
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildFeatureItem(
                      title: 'Property Trends',
                      icon: Icons.trending_up,
                      onTap: () {
                        // Navigate to Property Trends screen
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildFeatureItem(
                      title: 'Investment Analysis',
                      icon: Icons.assessment,
                      onTap: () {
                        // Navigate to Investment Analysis screen
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildFeatureItem(
                      title: 'Area Guides',
                      icon: Icons.location_city,
                      onTap: () {
                        // Navigate to Area Guides screen
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  'Main Content Area',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24.0,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18.0,
          ),
        ],
      ),
    );
  }
}
