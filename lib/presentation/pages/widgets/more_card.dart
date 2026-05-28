import 'package:app_axion/data/car.dart';
import 'package:flutter/material.dart';

class MoreCard extends StatelessWidget {
  final Car car;
  const MoreCard({super.key, required this.car});

  @override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[900], // Fundo escuro do card
      borderRadius: BorderRadius.circular(16),
    ),
    // 👇 Usamos uma Row como base do Card
    child: Row( 
      children: [
        
        // 1. BLOCO DA ESQUERDA (Textos)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              car.model,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '+${car.distance} km • +${car.fuelCapacity} L',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        
        // 👇 2. O SEGREDO: O Spacer() empurra a seta para o canto direito!
        const Spacer(), 
        
        // 3. BLOCO DA DIREITA (Preço e Seta)
        Text(
          '\$${car.pricePerHour}/h',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10), // Um pequeno espaço entre o preço e a seta
        const Icon(
          Icons.arrow_forward_ios, // Ícone de seta apontando para a direita
          color: Colors.white54, 
          size: 16, // Tamanho sutil e elegante
        ),
        
      ],
    ),
  );
}
}