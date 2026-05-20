import 'package:app_axion/data/car.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({super.key, required this.car});
  
  @override
Widget build(BuildContext context) {
  return GestureDetector(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Ajustado para um visual mais equilibrado
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Adicionado um fundo escuro (combina com a proposta premium do Axion)
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda do card
        children: [
          // Centraliza apenas a imagem do carro
          Center(
            child: Image.asset('assets/car_image.png', height: 120),
          ),
          const SizedBox(height: 10),
          Text(
            car.model, 
            style: const TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          
          // Apenas UMA Row principal com spaceBetween resolve o espaçamento das laterais
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/gps.png', width: 20, height: 20),
                  const SizedBox(width: 6), // Espaço entre o ícone e o texto
                  Text(
                    '${car.distance} km', // Corrigido e simplificado
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              Text(
                '\$${car.pricePerHour}/h',
                style:const TextStyle(
                  fontSize: 14, 
                  color: Colors.grey,
                ),
              ),
              // Bloco do Combustível
              Row(
                children: [
                  Image.asset('assets/pump.png', width: 20, height: 20),
                  const SizedBox(width: 6), // Espaço entre o ícone e o texto
                  Text(
                    '${car.fuelCapacity} L', // Corrigido e simplificado
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}