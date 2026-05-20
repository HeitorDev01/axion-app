import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/widgets/car_card.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key});

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
            car: Car(model: 'Fortuner GR',
             distance: 870, 
             fuelCapacity: 50, 
             pricePerHour: 45,
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
            )
        ],
      ),
    );
  }
}