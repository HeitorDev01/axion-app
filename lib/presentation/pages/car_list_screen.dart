import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/widgets/car_card.dart';
import 'package:flutter/material.dart';

class CarListScreen extends StatelessWidget {
  // Cada carro aponta para a sua própria foto em assets/cars/
  final List<Car> cars = [
    Car(model: 'Porsche 911 Carrera S', distance: 320, fuelCapacity: 64, pricePerHour: 89),
    Car(model: 'Lamborghini Huracán STO', distance: 210, fuelCapacity: 80, pricePerHour: 149),
    Car(model: 'Mercedes-Benz Classe G', distance: 540, fuelCapacity: 100, pricePerHour: 95),
    Car(model: 'BMW M4 Competition', distance: 410, fuelCapacity: 59, pricePerHour: 79),
    Car(model: 'Audi R8 V10', distance: 280, fuelCapacity: 83, pricePerHour: 129),
    Car(model: 'Range Rover Sport', distance: 620, fuelCapacity: 90, pricePerHour: 85),
    Car(model: 'Porsche Macan', distance: 480, fuelCapacity: 75, pricePerHour: 72),
    Car(model: 'Ford Ranger Raptor', distance: 870, fuelCapacity: 80, pricePerHour: 55),
    Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45),
  ];
  CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sem AppBar: o título faz parte da rolagem, como em app de aluguel
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header()),
            SliverList.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) => CarCard(car: cars[index]),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha de cima: marca de um lado, usuário do outro
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BEM-VINDO AO',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'AXION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24),
                ),
                child: const CircleAvatar(
                  radius: 21,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            'Escolha Seu Carro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${cars.length} carros premium disponíveis agora',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
