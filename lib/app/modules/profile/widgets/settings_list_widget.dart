import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';

class SettingItemList extends StatelessWidget {
  final Color color;
  final double iconSize;
  final String? iconData;
  final String name;
  final VoidCallback onTap;
  const SettingItemList({
    super.key,
    this.iconSize = 24,
    required this.name,
    required this.onTap,
    this.iconData,
    this.color = AppColors.profileData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF3F3F5),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  iconData != null
                      ? CrashSafeImage(color: color, iconData, width: iconSize)
                      : Container(),
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.arrow_forward_ios, size: 16, color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
