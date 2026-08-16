import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

/// Estilo do mapa do Axion: o "Dark Matter" da CARTO, um mapa todo preto que
/// combina com o visual premium do app (e continua sendo gratuito, como o
/// OpenStreetMap, que é a fonte dos dados).
const String kDarkTileUrl =
    'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';

/// Versão sem nomes de ruas — usada na miniatura, onde os textos ficariam
/// pequenos demais para ler.
const String kDarkTileUrlNoLabels =
    'https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png';

/// Cor de fundo enquanto os tiles ainda não carregaram (evita o flash branco).
/// É a mesma do app, para o mapa emendar com o resto das telas.
const Color kMapBackground = kAppBackground;

/// Camada de tiles escura. Use `labels: false` para a versão limpa.
TileLayer darkTileLayer({bool labels = true}) {
  return TileLayer(
    urlTemplate: labels ? kDarkTileUrl : kDarkTileUrlNoLabels,
    subdomains: const ['a', 'b', 'c', 'd'],
    // Boa prática: identifica o app para não bloquearem o acesso ao mapa
    userAgentPackageName: 'com.seu_usuario.app_axion',
    retinaMode: true, // usa o {r} da URL -> tiles nítidos em telas de celular
    tileBuilder: _dimTile,
  );
}

/// Deixa os tiles um pouco mais escuros ainda, para o card e os marcadores
/// ganharem destaque sobre o mapa.
Widget _dimTile(BuildContext context, Widget tileWidget, TileImage tile) {
  return ColorFiltered(
    colorFilter: const ColorFilter.mode(Color(0x33000000), BlendMode.srcATop),
    child: tileWidget,
  );
}

/// Créditos obrigatórios da CARTO e do OpenStreetMap.
///
/// Não usamos o `RichAttributionWidget` do pacote porque ele só se ancora na
/// parte de baixo do mapa — que aqui fica escondida atrás do card do carro.
/// Este selo é colocado no topo, onde continua sempre visível.
Widget mapAttributionChip() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white12),
    ),
    child: const Text(
      '© OpenStreetMap · CARTO',
      style: TextStyle(color: Colors.white54, fontSize: 10),
    ),
  );
}
