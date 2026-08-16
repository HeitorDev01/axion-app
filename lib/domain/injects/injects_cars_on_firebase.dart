import 'package:app_axion/data/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// Função para enviar os carros para o banco
Future<void> injectsCarsOnFirebase() async {
  try {
    // 1. Cria um carro de exemplo
    Car carroExemplo = Car(
      model: 'Fortuner GR',
      distance: 870,
      fuelCapacity: 50,
      pricePerHour: 45,
    );

    // 2. Envia para a coleção 'cars' usando o toMap()
    await FirebaseFirestore.instance
        .collection('cars')
        .add(carroExemplo.toMap());

    debugPrint('✅ Carro salvo com sucesso no Firebase!');
  } catch (e) {
    debugPrint('❌ Erro ao salvar carro: $e');
  }
}