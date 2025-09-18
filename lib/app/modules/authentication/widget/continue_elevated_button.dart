

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueElevatedButton extends StatelessWidget {
  final VoidCallback ontap;
  final String logoPath;
  final String name;
  const ContinueElevatedButton({
    super.key,
    required this.logoPath,
    required this.name, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 55.h,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(48.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10.r,
              child: Image.asset(
                logoPath,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 8,),
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 14.sp, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
