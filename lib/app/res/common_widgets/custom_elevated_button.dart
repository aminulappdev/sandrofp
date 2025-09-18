import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final VoidCallback? onPress;
  final Color? color;
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.iconData,
    this.onPress,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData != null ? Icon(iconData, color: Colors.black) : Container(),
          widthBox10,
          Text(
            'Get Started',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
