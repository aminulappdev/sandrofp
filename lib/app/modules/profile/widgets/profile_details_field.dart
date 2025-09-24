

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ProfileDataField extends StatelessWidget {
  const ProfileDataField({
    super.key,
  
    required this.keyData,
    required this.valueData,
    required this.iconData, this.width = 180,
  });

  final String keyData;
  final String valueData;
  final IconData iconData;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: width!.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),

        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData, color: Colors.black),
            widthBox10,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    keyData,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120.w,
                  child: Text(
                    valueData,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}