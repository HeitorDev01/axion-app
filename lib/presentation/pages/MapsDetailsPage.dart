import 'package:app_axion/data/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
class MapsDetailsPage extends StatelessWidget {
  final Car car;

  const MapsDetailsPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(51.5, -0.09), // Coordenadas iniciais (Londres)
              initialZoom: 13.0,                  // Nível de zoom inicial
            ),
            // 👇 A propriedade 'layers' agora se chama 'children' (como quase tudo no Flutter)
            children: [ 
              TileLayer( 
                // URL atualizada e recomendada pelo OpenStreetMap
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", 
                // É uma boa prática informar o nome do seu pacote para não bloquearem seu acesso ao mapa gratuito
                userAgentPackageName: 'com.seu_usuario.app_axion', 
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: carDetailsCard(car: car),
          ),

        ],
      ),
    );
  }
}

Widget carDetailsCard({required Car car}) {
  return SizedBox(  
    height: 380,
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(height: 20),
              Text('${car.model}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                children:[
                  const Icon(Icons.directions_car, color: Colors.white, size: 16),
                  const SizedBox(width: 5),
                  Text('>${car.distance} km',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.local_gas_station, color: Colors.white, size: 14),
                   const SizedBox(width: 5),
                   Text('${car.fuelCapacity} L',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ]
              )
            ]
          )
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                 const Text("Características", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                 const SizedBox(height: 20,),
                 featureIcons(),
                 const SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('\$${car.pricePerHour}/Dia', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),),
                     child: Text('Reserve Agora', style: TextStyle(color:Colors.white,)
                      ),
                    ),
                  ]
                 )
              ]
             ),
          )
        ),
        Positioned(
          top: 50,
          right: 30,
          child: Image.asset('assets/white_car.png'),
        ),
      ],
    ),
  );    
}

Widget featureIcons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:[
      Expanded(child: featureIcon(Icons.local_gas_station, 'Combustível', 'Gasolina'),),
      Expanded(child: featureIcon(Icons.speed, 'Aceleração', '0 - 100 km/h'),),
      Expanded(child: featureIcon(Icons.ac_unit, 'Frio', 'Climatizador'),),
    ]
  );
}

Widget featureIcon(IconData icon, String title, String value) {
  return Container(
    // Espaçamento interno para o contorno não colar no texto
    padding: const EdgeInsets.all(12), 
    decoration: BoxDecoration(
      // 👇 O CONTORNO É DEFINIDO AQUI
      border: Border.all(
        color: Colors.black.withOpacity(0.2), // Preto com 20% de opacidade (elegante)
        width: 1.5, // Espessura da linha
      ),
      borderRadius: BorderRadius.circular(16), // Bordas arredondadas
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black, size: 28), 
        const SizedBox(height: 5), // Aumentei levemente o espaço para respirar melhor
        Text(
          title, 
          style: const TextStyle(color: Colors.grey, fontSize: 12),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 5),
        Text(
          value, 
          style: const TextStyle(
            color: Colors.black, 
            fontSize: 14, 
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );
}