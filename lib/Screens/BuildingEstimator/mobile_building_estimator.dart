import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/ConstructionCalculationModel.dart';

class MobileBuildingEstimator extends StatefulWidget {
  @override
  _MobileBuildingEstimatorState createState() =>
      _MobileBuildingEstimatorState();
}

class _MobileBuildingEstimatorState extends State<MobileBuildingEstimator> {
  final _formKey = GlobalKey<FormState>();

  String _selectedCity = 'Islamabad';
  final List<String> _cities = ['Islamabad', 'Rawalpindi'];

  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _brickCostController = TextEditingController();
  final TextEditingController _cementCostController = TextEditingController();
  final TextEditingController _pipeCostController = TextEditingController();
  final TextEditingController _wireCostController = TextEditingController();

  Map<String, dynamic>? _calculationResult;

  void _calculateCost() {
    if (_formKey.currentState!.validate()) {
      final model = ConstructionCalculationModel(
        city: _selectedCity,
        totalArea: double.parse(_areaController.text),
        brickCost: double.parse(_brickCostController.text),
        cementCost: double.parse(_cementCostController.text),
        pipeCost: double.parse(_pipeCostController.text),
        wireCost: double.parse(_wireCostController.text),
      );

      setState(() {
        _calculationResult = model.calculateConstructionCost();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(

          'Construction Cost Calculator - Mobile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildDropdownField(
                      label: 'City',
                      value: _selectedCity,
                      items: _cities,
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value!;
                        });
                      },
                    ),
                    SizedBox(height: 12,),
                    _buildTextField(
                      controller: _areaController,
                      label: 'Total Area (Marlas)',
                    ),
                    _buildTextField(
                      controller: _brickCostController,
                      label: 'Brick Cost',
                    ),
                    _buildTextField(
                      controller: _cementCostController,
                      label: 'Cement Cost',
                    ),
                    _buildTextField(
                      controller: _pipeCostController,
                      label: 'Pipe Cost (per ft)',
                    ),
                    _buildTextField(
                      controller: _wireCostController,
                      label: 'Electric Wire Cost (per meter)',
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(fontSize: 18),
                      ),

                      onPressed: _calculateCost,
                      child: Text('Calculate Cost'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _calculationResult != null
                  ? _buildResultSection(_calculationResult!)
                  : Text(
                'Enter details and calculate',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((city) => DropdownMenuItem(value: city, child: Text(city)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.pink.shade50,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.pink.shade50,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Required' : null,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildResultSection(Map<String, dynamic> result) {
    return Card(
      color: Colors.pink.shade300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculation Results',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Inflation Factor: ${result['inflationFactor'].toStringAsFixed(2)}x',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Foundation Cost: ${result['foundationCost'].toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Plumbing & Electric Cost: ${result['plumbingAndElectricCost'].toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Total Cost: ${result['totalCost'].toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            SfCircularChart(
              series: <PieSeries<Map<String, dynamic>, String>>[
                PieSeries(
                  dataSource: [
                    {
                      'category': 'Foundation',
                      'value': result['foundationPercentage']
                    },
                    {
                      'category': 'Plumbing & Electric',
                      'value': result['plumbingElectricPercentage']
                    },
                  ],
                  xValueMapper: (data, _) => data['category'],
                  yValueMapper: (data, _) => data['value'],
                  dataLabelMapper: (data, _) =>
                  '${data['category']}: ${(data['value'])}%',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ],
              title: ChartTitle(
                text: 'Cost Breakdown',
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
