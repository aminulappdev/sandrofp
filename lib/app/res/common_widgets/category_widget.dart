
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color? bgColor;
  final Color? textColor;
  final double fontSize;

  const CategoryWidget({
    super.key,
    this.bgColor = AppColors.grey,
    this.textColor = Colors.black,
    this.fontSize = 14,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
