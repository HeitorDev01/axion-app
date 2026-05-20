import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/widgets/car_card.dart';
import 'package:flutter/material.dart';

class CarListScreen extends StatelessWidget {
  final List<Car> cars = [
    Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45),
    Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45),
    Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45),
  ]; // Replace with actual car data
  CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha Seu Carro'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(itemCount: cars.length, itemBuilder: (context, index) {
        final car = cars[index];
        return CarCard(car: cars[index]);
      }
      ),
    );
  }
}