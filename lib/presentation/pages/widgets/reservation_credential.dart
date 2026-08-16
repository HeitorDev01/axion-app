import 'dart:math';

import 'package:app_axion/data/car.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Credencial de reserva — dados fictícios, gerados na hora e nada é salvo.
/// Serve só para o botão "Reserve Agora" ter um retorno visual.
class Reservation {
  final Car car;
  final String code;
  final String holder;
  final DateTime pickup;
  final DateTime dropoff;
  final int dailies;

  const Reservation({
    required this.car,
    required this.code,
    required this.holder,
    required this.pickup,
    required this.dropoff,
    required this.dailies,
  });

  /// O preço na tela do mapa é por diária, então o total segue a mesma conta.
  double get total => car.pricePerHour * dailies;

  factory Reservation.fake(Car car) {
    final random = Random();
    const letters = 'ABCDEFGHJKLMNPQRSTUVWXYZ'; // sem I e O (confundem com 1/0)
    final code = List.generate(
      4,
      (_) => letters[random.nextInt(letters.length)],
    ).join();
    final number = random.nextInt(9000) + 1000;

    // Retirada amanhã às 10h, devolução 3 diárias depois
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final pickup = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10);
    const dailies = 3;

    return Reservation(
      car: car,
      code: 'AXN-$code$number',
      holder: 'James Rodrigues',
      pickup: pickup,
      dropoff: pickup.add(const Duration(days: dailies)),
      dailies: dailies,
    );
  }
}

/// Abre a credencial numa folha que sobe de baixo.
Future<void> showReservationCredential(BuildContext context, Car car) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.7),
    builder: (context) => _CredentialSheet(reservation: Reservation.fake(car)),
  );
}

class _CredentialSheet extends StatelessWidget {
  final Reservation reservation;
  const _CredentialSheet({required this.reservation});

  @override
  Widget build(BuildContext context) {
    final car = reservation.car;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      decoration: const BoxDecoration(
        color: kSheetBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border(top: BorderSide(color: Colors.white12)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              const SizedBox(height: 22),

              // Confirmação
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.check, color: Colors.black, size: 30),
              ),
              const SizedBox(height: 14),
              const Text(
                'Reserva confirmada',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Apresente esta credencial na retirada',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 22),

              // A credencial em si
              Container(
                decoration: BoxDecoration(
                  color: kCardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Faixa com a foto do carro
                    Stack(
                      children: [
                        SizedBox(
                          height: 110,
                          width: double.infinity,
                          child: Image.asset(car.image, fit: BoxFit.cover),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.9),
                                ],
                                stops: const [0.3, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: 10,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  car.model,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Text(
                                'AXION',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _field('TITULAR', reservation.holder),
                              ),
                              Expanded(
                                child: _field(
                                  'DIÁRIAS',
                                  '${reservation.dailies}',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _field(
                                  'RETIRADA',
                                  _formatDate(reservation.pickup),
                                ),
                              ),
                              Expanded(
                                child: _field(
                                  'DEVOLUÇÃO',
                                  _formatDate(reservation.dropoff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Picote, como num bilhete
                    const _DashedDivider(),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      child: Row(
                        children: [
                          _FakeQrCode(seed: reservation.code),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _field('CÓDIGO', reservation.code),
                                const SizedBox(height: 14),
                                _field(
                                  'TOTAL',
                                  '\$${reservation.total.toStringAsFixed(0)}',
                                  big: true,
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

              const SizedBox(height: 14),
              Text(
                'Reserva de demonstração — nenhum dado foi salvo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Concluir',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Rótulo pequeno em cima, valor em destaque embaixo
  Widget _field(String label, String value, {bool big = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 10,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: big ? 22 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)} · ${two(d.hour)}:${two(d.minute)}';
  }
}

/// Linha picotada que separa as partes do bilhete.
class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashWidth = 5.0;
          const gapWidth = 4.0;
          final count = (constraints.maxWidth / (dashWidth + gapWidth)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              count,
              (_) => Container(
                width: dashWidth,
                height: 1,
                color: Colors.white24,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Quadriculado no estilo QR. É só enfeite — o desenho vem do código da
/// reserva, então cada credencial tem o seu padrão, mas não codifica nada.
class _FakeQrCode extends StatelessWidget {
  final String seed;
  const _FakeQrCode({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: const Size(72, 72),
        painter: _QrPainter(seed.hashCode),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  final int seed;
  const _QrPainter(this.seed);

  static const int _cells = 15;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(seed);
    final cell = size.width / _cells;
    final paint = Paint()..color = Colors.black;

    for (var y = 0; y < _cells; y++) {
      for (var x = 0; x < _cells; x++) {
        if (_isFinderArea(x, y)) continue;
        if (random.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(x * cell, y * cell, cell, cell),
            paint,
          );
        }
      }
    }

    // Os três quadrados dos cantos, que dão a cara de QR code
    for (final corner in [const Point(0, 0), const Point(8, 0), const Point(0, 8)]) {
      _drawFinder(canvas, paint, corner.x * cell, corner.y * cell, cell);
    }
  }

  bool _isFinderArea(int x, int y) {
    const size = 7;
    final topLeft = x < size && y < size;
    final topRight = x >= _cells - size && y < size;
    final bottomLeft = x < size && y >= _cells - size;
    return topLeft || topRight || bottomLeft;
  }

  void _drawFinder(Canvas canvas, Paint paint, double x, double y, double cell) {
    canvas.drawRect(Rect.fromLTWH(x, y, cell * 7, cell * 7), paint);
    canvas.drawRect(
      Rect.fromLTWH(x + cell, y + cell, cell * 5, cell * 5),
      Paint()..color = Colors.white,
    );
    canvas.drawRect(
      Rect.fromLTWH(x + cell * 2, y + cell * 2, cell * 3, cell * 3),
      paint,
    );
  }

  @override
  bool shouldRepaint(_QrPainter oldDelegate) => oldDelegate.seed != seed;
}
