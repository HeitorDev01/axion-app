import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/pages/maps_details_page.dart';
import 'package:app_axion/presentation/pages/widgets/car_card.dart';
import 'package:app_axion/presentation/pages/widgets/circle_icon_button.dart';
import 'package:app_axion/presentation/pages/widgets/dark_map_layer.dart';
import 'package:app_axion/presentation/pages/widgets/more_card.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class CarDetailsPage extends StatefulWidget {
  final Car car;
  const CarDetailsPage({super.key, required this.car});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
   _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this
    );

    // Miniatura do mapa aparece suavemente ao abrir a página
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeOut);

    _controller!.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 66,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CircleIconButton(
            icon: Icons.arrow_back,
            tooltip: 'Voltar',
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Informações'),
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarCard(car: widget.car),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 180,
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                    color: kCardBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kBorderColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage:
                            AssetImage('assets/user.png'),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'James Rodrigues',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '\$4,500.00',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MapsDetailsPage(car: widget.car)));
                      },
                      child: Container(
                        // A altura vem do SizedBox da Row (os dois cards ficam iguais)
                        decoration: BoxDecoration(
                          color: kMapBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: kBorderColor),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeTransition(
                            opacity: _animation!,
                            child: _mapPreview(),
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
              ),
            ),

            // Título da seção dos pacotes
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 28, 20, 4),
              child: Text(
                'Outros pacotes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

           Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
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
                        model: '${widget.car.model} • $currentPackage',
                        distance: widget.car.distance + (100 * multiplier),
                        fuelCapacity: widget.car.fuelCapacity + (100 * multiplier),
                        pricePerHour: widget.car.pricePerHour + (10 * multiplier),
                      ),
                    ),
                  );
                }),
              ),
            )
        ],
      ),
      ),
    );
  }

  // Miniatura do mapa escuro (sem interação: o toque abre a página do mapa)
  Widget _mapPreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // O IgnorePointer é necessário: o FlutterMap engole o toque mesmo com
        // as interações desligadas, e aí o GestureDetector de fora nunca abria
        // a página do mapa.
        IgnorePointer(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter: kCarLocation,
              initialZoom: 14.0,
              backgroundColor: kMapBackground,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              darkTileLayer(labels: false),
              MarkerLayer(
                markers: const [
                  Marker(
                    point: kCarLocation,
                    width: 26,
                    height: 26,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.white54, blurRadius: 12, spreadRadius: 2),
                        ],
                      ),
                      child: Icon(Icons.directions_car, color: Colors.black, size: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: const Text(
              'Ver no mapa',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}