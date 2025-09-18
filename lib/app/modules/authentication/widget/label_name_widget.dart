import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelName extends StatelessWidget {
  final String label;
  const LabelName({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
