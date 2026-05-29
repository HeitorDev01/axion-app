import 'package:app_axion/data/car.dart';
import 'package:app_axion/data/datasource/firebase_car_data_source.dart';
import 'package:app_axion/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final FirebaseCarDataSource dataSource;

  CarRepositoryImpl(this.dataSource);

  @override
  Future<List<Car>> fetchCars() async {
    return dataSource.getCars();
  }
}
