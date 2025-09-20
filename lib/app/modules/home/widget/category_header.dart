import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';

class CategoryHeader extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const CategoryHeader({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        InkWell(
          onTap: onTap,
          child: Container(
            height: 38,
            width: 95,
            decoration: BoxDecoration(
              color: Color(0xffEBF2EE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'View all',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greenColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
