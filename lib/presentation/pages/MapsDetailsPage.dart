import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // 👈 IMPORTANTE: Necessário para ler as coordenadas LatLng

class MapsDetailsPage extends StatelessWidget {
  const MapsDetailsPage({super.key});

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
            child: carDetailsCard(),
          ),
        ],
      ),
    );
  }
}

Widget carDetailsCard() {
  return SizedBox(  
    height: 50,
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: const BorderRadius.only(
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
            children:[
              SizedBox(height: 20),
              Text('car.model', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                children:[
                  Icon(Icons.directions_car, color: Colors.white, size: 16),
                ]
              )
            ]
          )
        ),

      ],
    ),
  );    
}