import 'package:app_axion/data/car_images.dart';

class Car {
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;

  /// Foto do carro. Quando não é informada, é deduzida a partir do modelo
  /// (ver `car_images.dart`), então cada carro sempre tem a sua própria imagem.
  final String image;

  Car({
    required this.model,
    required this.distance,
    required this.fuelCapacity,
    required this.pricePerHour,
    String? image,
  }) : image = image ?? carImageFor(model);

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'distance': distance,
      'fuelCapacity': fuelCapacity,
      'pricePerHour': pricePerHour,
      'image': image,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['model'] ?? 'Desconhecido',
      distance: (map['distance'] ?? 0).toDouble(),
      fuelCapacity: (map['fuelCapacity'] ?? 0).toDouble(),
      pricePerHour: (map['pricePerHour'] ?? 0).toDouble(),
      image: map['image'] as String?,
    );
  }
}
