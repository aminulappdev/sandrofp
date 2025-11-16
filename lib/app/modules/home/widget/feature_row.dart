import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureRow extends StatelessWidget {
  final String title;
  final FontWeight titleWeight;
  final Widget widget;
  final Color textColor = Color(0xff595959);
  FeatureRow({
    super.key,
    required this.title,
    required this.widget,
    this.titleWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: titleWeight,
            color: Colors.black,
          ),
        ),

        widget,
      ],
    );
  }
}
