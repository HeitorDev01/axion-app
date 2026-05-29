import 'package:app_axion/domain/repositories/usecases/get_cars.dart';
import 'package:app_axion/presentation/bloc/car_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:app_axion/data/datasource/firebase_car_data_source.dart';
import 'package:app_axion/domain/repositories/car_repository.dart';
import 'package:app_axion/data/repositories/car_repository_impl.dart';

GetIt getIt = GetIt.instance;

void initInjection() {
 try{
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton< FirebaseCarDataSource>(() =>  FirebaseCarDataSource(getIt<FirebaseFirestore>())
  );
  getIt.registerLazySingleton< CarRepository>(() =>  CarRepositoryImpl(getIt<FirebaseCarDataSource>())
  );
  getIt.registerLazySingleton< GetCars>(() =>  GetCars(getIt<CarRepository>())
  );
  getIt.registerFactory(() => CarBloc(getCars: getIt<GetCars>()));
 }catch(e){ 
  throw e;
 }
}
