import 'package:app_axion/data/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCarDataSource {
  final FirebaseFirestore firestore;

  FirebaseCarDataSource(this.firestore);

  Future<List<Car>> getCars() async {
    var snapshot = await firestore.collection('cars').get();
    return snapshot.docs.map((doc) => Car.fromMap(doc.data())).toList();
  }
}