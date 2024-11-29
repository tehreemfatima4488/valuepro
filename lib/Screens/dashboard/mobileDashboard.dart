import 'package:flutter/material.dart';

import '../BuildingEstimator/building_estimator.dart';

class MobileDashboard extends StatefulWidget {
  @override
  _MobileDashboardState createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text('ValuePro AI',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 32),),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Building Cost Estimator',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white,letterSpacing: 4),
            ),
            SizedBox(height: 16.0),
            _buildFeatureItem(
              title: 'Building Cost Estimator',
              icon: Icons.attach_money,
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BuildingEstimator()));
                // Navigate to Building Cost Estimator screen
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
          Icon(icon,color: Colors.white,),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,

              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios,color: Colors.white,),
        ],
      ),
    );
  }
}
