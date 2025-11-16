
import 'package:flutter/material.dart';

class ColorPlate extends StatelessWidget {
  final Color color;
  const ColorPlate({super.key, required this.color, required bool isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: CircleAvatar(
        backgroundColor: Color(0xff595959),
        radius: 15,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 14,
          child: CircleAvatar(backgroundColor: color, radius: 13),
        ),
      ),
    );
  }
}