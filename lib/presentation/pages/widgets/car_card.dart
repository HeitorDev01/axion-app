import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/car_details_page.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarDetailsPage(car: car)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: kCardBackground, // Fundo escuro (proposta premium do Axion)
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kBorderColor),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        // Faz a foto respeitar o arredondamento do card
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Cada carro tem a sua própria foto
                AspectRatio(
                  aspectRatio: 25 / 16,
                  child: Image.asset(
                    car.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Degradê para o nome do carro ficar legível sobre a foto
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        stops: const [0.45, 1.0],
                      ),
                    ),
                  ),
                ),

                // Etiqueta de preço flutuando no canto da foto
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      '\$${car.pricePerHour.toStringAsFixed(0)}/h',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: Text(
                    car.model,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Uma Row com spaceBetween resolve o espaçamento das laterais.
            // Cada bloco é Flexible para não estourar em telas estreitas nem
            // quando o usuário aumenta a fonte do sistema.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: _spec(
                      'assets/gps.png',
                      '${car.distance.toStringAsFixed(0)} km',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: _spec(
                      'assets/pump.png',
                      '${car.fuelCapacity.toStringAsFixed(0)} L',
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Ver detalhes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white54,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bloco de ícone + valor (distância, combustível...)
  Widget _spec(String icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, width: 20, height: 20),
        const SizedBox(width: 6), // Espaço entre o ícone e o texto
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
