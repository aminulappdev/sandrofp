// app/modules/home/widget/color_plate.dart
import 'package:flutter/material.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';

class ColorPlate extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorPlate({super.key, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.greenColor : Colors.grey.shade300,
          width: isSelected ? 3 : 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.greenColor.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
