import 'package:flutter/material.dart';

class HeightRulerCard extends StatelessWidget {
  const HeightRulerCard({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 120,
    this.max = 220,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F1E8);
    const accent = Color(0xFFD39A2C);

    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Height (cm)',
            style: TextStyle(
              color: Colors.black.withOpacity(0.45),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$value',
            style: const TextStyle(
              color: accent,
              fontSize: 44,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),

          // Ruler area
          SizedBox(
            height: 70,
            child: LayoutBuilder(
              builder: (context, c) {
                final width = c.maxWidth;
                final t = (value - min) / (max - min); // 0..1
                final x = t.clamp(0.0, 1.0) * width;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ticks
                    CustomPaint(
                      size: Size(width, 56),
                      painter: _RulerPainter(min: min, max: max),
                    ),

                    // vertical marker line
                    Positioned(
                      left: x - 1,
                      top: 6,
                      bottom: 10,
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // small triangle pointer
                    Positioned(
                      left: x - 6,
                      top: 0,
                      child: CustomPaint(
                        size: const Size(12, 10),
                        painter: _TrianglePainter(color: accent),
                      ),
                    ),

                    // invisible slider overlay to drag
                    Positioned.fill(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 0, // hide track
                          activeTrackColor: Colors.transparent,
                          inactiveTrackColor: Colors.transparent,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0, // hide thumb
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 18,
                          ),
                        ),
                        child: Slider(
                          value: value.toDouble(),
                          min: min.toDouble(),
                          max: max.toDouble(),
                          onChanged: (v) => onChanged(v.round()),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  _RulerPainter({required this.min, required this.max});

  final int min;
  final int max;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.22)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // draw ticks: minor every 1, medium every 5, major every 10
    final total = max - min;
    final pxPerUnit = size.width / total;

    for (int v = min; v <= max; v++) {
      final x = (v - min) * pxPerUnit;

      final isMajor = (v % 10 == 0);
      final isMedium = (v % 5 == 0);

      final top = 18.0;
      final h = isMajor
          ? 28.0
          : isMedium
          ? 20.0
          : 14.0;

      canvas.drawLine(Offset(x, top), Offset(x, top + h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RulerPainter oldDelegate) {
    return oldDelegate.min != min || oldDelegate.max != max;
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
