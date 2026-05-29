class Car {
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;

  Car({
    required this.model,
    required this.distance,
    required this.fuelCapacity,
    required this.pricePerHour,
  });

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'distance': distance,
      'fuelCapacity': fuelCapacity,
      'pricePerHour': pricePerHour,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['model'] ?? 'Desconhecido',
      distance: (map['distance'] ?? 0).toDouble(),
      fuelCapacity: (map['fuelCapacity'] ?? 0).toDouble(),
      pricePerHour: (map['pricePerHour'] ?? 0).toDouble(),
    );
  }
}