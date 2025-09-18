
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationFooterSection extends StatelessWidget {
  final String fTextName;
  final Color fTextColor;
  final String sTextName;
  final Color sTextColor;
  final VoidCallback ontap;
  const AuthenticationFooterSection({
    super.key,
    required this.fTextName,
    required this.fTextColor,
    required this.sTextName,
    required this.sTextColor,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: ontap,
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: fTextName,
              style: GoogleFonts.poppins(
                  color: fTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400)),
          TextSpan(
              text: sTextName,
              style: GoogleFonts.poppins(
                  color: sTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500)),
        ])),
      ),
    );
  }
}