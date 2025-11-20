import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final String? iconData;
  final VoidCallback? onPress;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? iconColor;
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.iconData,
    this.onPress,
    this.color = AppColors.greenColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: borderColor!, width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? CrashSafeImage(
                    color: iconColor ?? null,
                    iconData!,
                    height: 20.h,
                    width: 20.w,
                  )
                : Container(),
            widthBox10,
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
