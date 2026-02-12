import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ToolbarButton(this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 20),
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 8),
      constraints: BoxConstraints(),
    );
  }
}
