// Teste de fumaça: garante que o app abre na tela de boas-vindas e que o
// botão "Começar" leva para a lista de carros.
//
// Não toca no Firebase: a MyApp só monta a OnbordingPage, que é offline.

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_axion/main.dart';

void main() {
  testWidgets('abre no onboarding e navega para a lista de carros', (
    WidgetTester tester,
  ) async {
    // A tela padrão do teste é 800x600 (baixa demais). Simula um celular.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    // Tela de boas-vindas
    expect(find.textContaining('Bem-vindo ao Axion'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);

    // A fonte usada nos testes é maior que a real e pode empurrar o botão para
    // fora da tela, então garantimos que ele está visível antes de tocar.
    await tester.ensureVisible(find.text('Começar'));
    await tester.pumpAndSettle();

    // Toca em "Começar" e espera a transição de rota terminar
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    // Lista de carros
    expect(find.text('Escolha Seu Carro'), findsOneWidget);
    expect(find.text('Porsche 911 Carrera S'), findsOneWidget);
  });
}
