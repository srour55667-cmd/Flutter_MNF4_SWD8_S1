import 'package:flutter/material.dart';

class StepperCard extends StatelessWidget {
  const StepperCard({
    super.key,
    required this.label,
    required this.unit,
    required this.value,
    required this.onMinus,
    required this.onPlus,
    this.accentColor = const Color(0xFFD39A2C), // warm gold like the screenshot
    this.backgroundColor = const Color(0xFFF7F1E8),
  });

  final String label;
  final String unit;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final Color accentColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
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
            '$label ($unit)',
            style: TextStyle(
              color: Colors.black.withOpacity(0.45),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$value',
            style: TextStyle(
              color: accentColor,
              fontSize: 44,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundIconButton(icon: Icon(Icons.remove), onTap: onMinus),
              const SizedBox(width: 14),
              _RoundIconButton(icon: Icon(Icons.add), onTap: onPlus),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 3.5,
      shadowColor: Colors.black.withOpacity(0.18),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: icon, // placeholder, replaced below
          ),
        ),
      ),
    );
  }
}
