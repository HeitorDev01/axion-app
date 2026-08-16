import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MoreCard extends StatelessWidget {
  final Car car;
  const MoreCard({super.key, required this.car});

  @override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kCardBackground, // Fundo escuro do card
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kBorderColor),
    ),
    // 👇 Usamos uma Row como base do Card
    child: Row( 
      children: [
        
        // 1. BLOCO DA ESQUERDA (Textos)
        // 👇 O Expanded segura os nomes longos e ainda empurra o preço para
        // o canto direito (fazia o papel do antigo Spacer()).
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.model,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '+${car.distance.toStringAsFixed(0)} km • +${car.fuelCapacity.toStringAsFixed(0)} L',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // 2. BLOCO DA DIREITA (Preço e Seta)
        Text(
          '\$${car.pricePerHour.toStringAsFixed(0)}/h',
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