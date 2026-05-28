import 'dart:math';

import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/widgets/car_card.dart';
import 'package:app_axion/presentation/pages/widgets/more_card.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;
  const CarDetailsPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            Text('Informações'),
          ],
        ),
      ),
      body: Column(
        children: [
          CarCard(
            car: Car(model: car.model,
             distance: car.distance, 
             fuelCapacity: car.fuelCapacity, 
             pricePerHour: car.pricePerHour,
              ),
             ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5
                    )],
                  ),
                  child: Column(
                    children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: 
                            AssetImage('assets/user.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'James Rodrigues',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$4,500.00',
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                    ],
                  ),
                ),
              ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/maps.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 5
                        )]
                      ),
                    ),
                  )
                ],
              ),
            ),
           Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: List.generate(3, (index) {
                  // O 'index' começa em 0, então criamos um multiplicador (1, 2, 3...)
                  final multiplier = index + 1; 
                  final packageNames = ['Plus', 'Premium', 'Elite'];
                  final currentPackage = packageNames[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8), // Substitui o SizedBox entre os cards
                    child: MoreCard(
                      car: Car(
                        model: '${car.model} • $currentPackage',
                        distance: car.distance + (100 * multiplier),
                        fuelCapacity: car.fuelCapacity + (100 * multiplier),
                        pricePerHour: car.pricePerHour + (10 * multiplier),
                      ),
                    ),
                  );
                }),
              ),
            )
        ],
      ),
    );
  }
}