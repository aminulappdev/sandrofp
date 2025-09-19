import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';

class CircleIconWidget extends StatelessWidget {
  final String imagePath;
  final double radius;
  final double iconRadius;
  final Color color;
  final VoidCallback? onTap;
  const CircleIconWidget({
    super.key,
    required this.imagePath,
    this.radius = 17,
    this.color = AppColors.circleIconColor,
    required this.onTap,
    this.iconRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
        radius: radius,
        child: CrashSafeImage(imagePath, height: iconRadius, width: iconRadius),
      ),
    );
  }
}
