// lib/app/modules/home/widget/label_data.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelData extends StatelessWidget {
  final Color bgColor;
  final String title;
  final Color titleColor;
  final VoidCallback? onTap; 

  const LabelData({
    super.key,
    required this.bgColor,
    required this.title,
    this.titleColor = Colors.black,
    this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        height: 27,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: titleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}