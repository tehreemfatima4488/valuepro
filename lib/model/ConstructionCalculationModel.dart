
class ConstructionCalculationModel {
  final String city;
  final double totalArea;
  final double brickCost;
  final double cementCost;
  final double pipeCost;
  final double wireCost;

  ConstructionCalculationModel({
    required this.city,
    required this.totalArea,
    required this.brickCost,
    required this.cementCost,
    required this.pipeCost,
    required this.wireCost,
  });
  Map<String, dynamic> calculateConstructionCost() {
    // City-specific inflation rates
    final inflationRates = {
      'Islamabad': 1.0 + (1 + DateTime.now().millisecond % 3),
      'Rawalpindi': 1.0 + (1 + DateTime.now().millisecond % 2),
    };

    double inflationFactor = inflationRates[city] ?? 1.0;

    // Calculation logic
    double foundationCost = (totalArea * brickCost * 8) * inflationFactor;
    double plumbingAndElectricCost = (
        (totalArea * pipeCost * 15) +
            (totalArea * wireCost * 12)
    ) * inflationFactor;

    double totalCost = foundationCost + plumbingAndElectricCost;

    return {
      'inflationFactor': inflationFactor,
      'foundationCost': foundationCost,
      'plumbingAndElectricCost': plumbingAndElectricCost,
      'totalCost': totalCost,
      'foundationPercentage': (foundationCost / totalCost) * 100,
      'plumbingElectricPercentage': (plumbingAndElectricCost / totalCost) * 100,
    };
  }
}
