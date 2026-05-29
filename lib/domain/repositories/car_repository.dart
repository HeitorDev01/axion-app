import 'package:app_axion/data/car.dart';

abstract class CarRepository {
  Future<List<Car>> fetchCars();
}