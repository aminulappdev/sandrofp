import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';

import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback yesOntap;
  final VoidCallback noOntap;
  final IconData iconData;
  final String title;
  final String subtitle;
  final String noText;
  final String yesText;
  final bool isLoading; // New parameter to handle loading state

  const CustomDialog({
    super.key,
    required this.iconData,
    required this.title,
    required this.yesOntap,
    required this.noOntap,
    required this.subtitle,
    required this.noText,
    required this.yesText,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            heightBox10,
            subtitle == ''
                ? const SizedBox()
                : Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 110,
                  child: CustomElevatedButton(
                    title: noText,
                    color: Colors.white,
                    textColor: Colors.black,
                    borderColor: Colors.grey,
                    onPress: noOntap,
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: CustomElevatedButton(
                    title: yesText,
                    color: AppColors.greenColor,
                    textColor: Colors.white,
                    onPress: yesOntap,
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
