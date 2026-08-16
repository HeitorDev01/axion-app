import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/widgets/circle_icon_button.dart';
import 'package:app_axion/presentation/pages/widgets/dark_map_layer.dart';
import 'package:app_axion/presentation/pages/widgets/reservation_credential.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// Onde o carro está estacionado (mesmo ponto que o mapa abre centralizado)
const LatLng kCarLocation = LatLng(51.5, -0.09); // Londres

class MapsDetailsPage extends StatefulWidget {
  final Car car;

  const MapsDetailsPage({super.key, required this.car});

  @override
  State<MapsDetailsPage> createState() => _MapsDetailsPageState();
}

class _MapsDetailsPageState extends State<MapsDetailsPage>
    with SingleTickerProviderStateMixin {
  // Controla o brilho que pulsa em volta do marcador do carro
  late final AnimationController _pulse = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMapBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 66,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CircleIconButton(
            icon: Icons.arrow_back,
            tooltip: 'Voltar',
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: kCarLocation,
              initialZoom: 15.0,
              backgroundColor: kMapBackground,
            ),
            children: [
              darkTileLayer(),
              // Área de cobertura em volta do carro
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: kCarLocation,
                    radius: 420,
                    useRadiusInMeter: true,
                    color: Colors.white.withValues(alpha: 0.05),
                    borderColor: Colors.white.withValues(alpha: 0.25),
                    borderStrokeWidth: 1,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: kCarLocation,
                    width: 92,
                    height: 92,
                    child: _CarMarker(pulse: _pulse),
                  ),
                ],
              ),
            ],
          ),

          // Degradê no topo para o botão de voltar não sumir no mapa
          IgnorePointer(
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Créditos do mapa (exigidos pela CARTO/OpenStreetMap)
          Positioned(
            top: MediaQuery.of(context).padding.top + 18,
            right: 16,
            child: mapAttributionChip(),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: carDetailsCard(context: context, car: widget.car),
          ),
        ],
      ),
    );
  }
}

/// Marcador do carro: um ponto branco com um brilho que respira em volta.
class _CarMarker extends StatelessWidget {
  final Animation<double> pulse;
  const _CarMarker({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final t = pulse.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            // Halo que cresce e some
            Container(
              width: 40 + (t * 50),
              height: 40 + (t * 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.14 * (1 - t)),
              ),
            ),
            child!,
          ],
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.45),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(Icons.directions_car, color: Colors.black, size: 22),
      ),
    );
  }
}

Widget carDetailsCard({required BuildContext context, required Car car}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
    decoration: BoxDecoration(
      color: kSheetBackground,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      border: const Border(top: BorderSide(color: Colors.white12)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 24,
          spreadRadius: 4,
        ),
      ],
    ),
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Puxador, só para dar o ar de "folha" que sobe
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.model,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_car,
                          color: Colors.white54,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${car.distance.toStringAsFixed(0)} km',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.local_gas_station,
                          color: Colors.white54,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${car.fuelCapacity.toStringAsFixed(0)} L',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Foto do carro escolhido
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  car.image,
                  width: 130,
                  height: 78,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Text(
            'Características',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          featureIcons(),
          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'A partir de',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Text(
                    '\$${car.pricePerHour.toStringAsFixed(0)}/Dia',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                // Gera uma credencial fictícia na hora (nada é salvo)
                onPressed: () => showReservationCredential(context, car),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Reserve Agora',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

Widget featureIcons() {
  return Row(
    children: [
      Expanded(
        child: featureIcon(Icons.local_gas_station, 'Combustível', 'Gasolina'),
      ),
      const SizedBox(width: 10),
      Expanded(child: featureIcon(Icons.speed, 'Aceleração', '0 - 100 km/h')),
      const SizedBox(width: 10),
      Expanded(child: featureIcon(Icons.ac_unit, 'Frio', 'Climatizador')),
    ],
  );
}

Widget featureIcon(IconData icon, String title, String value) {
  return Container(
    // Espaçamento interno para o contorno não colar no texto
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.04),
      // 👇 O CONTORNO É DEFINIDO AQUI
      border: Border.all(color: Colors.white24),
      borderRadius: BorderRadius.circular(16), // Bordas arredondadas
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
