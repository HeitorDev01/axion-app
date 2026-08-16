import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Paleta do Axion. O app inteiro é escuro, então as cores ficam centralizadas
/// aqui para as telas não saírem cada uma com um tom de preto diferente.
const Color kAppBackground = Color(0xff0b0b0d); // fundo das telas
const Color kCardBackground = Color(0xff141416); // cards (carro, mapa, dono)
const Color kSheetBackground = Color(0xff121214); // folha que sobe no mapa
const Color kBorderColor = Colors.white10; // contorno sutil dos cards

/// Tema escuro usado pelo MaterialApp. Deixa a AppBar transparente e sem o
/// tingimento roxo que o Material 3 aplica sozinho ao rolar a página.
ThemeData buildAxionTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xff8e8e93), // cinza neutro: o destaque é o branco
    brightness: Brightness.dark,
  ).copyWith(surface: kAppBackground);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: kAppBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}
