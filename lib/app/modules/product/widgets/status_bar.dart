import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/status_card.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class StatusBar extends StatelessWidget {
  final String? firstIconPath;
  final String? secondIconPath;
  final String? thirdIconPath;
  final Color? firstBgColor;
  final Color? secondBgColor;
  final Color? thirdBgColor;
  final Color? firtsIconColor;
  final Color? secondIconColor;
  final Color? thirdIconColor;
  final String? firstName;
  final String? secondName;
  final String? thirdName;
  const StatusBar({
    super.key,
    this.firstBgColor,
    this.secondBgColor,
    this.thirdBgColor,
    this.firtsIconColor,
    this.secondIconColor,
    this.thirdIconColor,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.firstIconPath,
    this.secondIconPath,
    this.thirdIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: firstBgColor,
              radius: 25,
              child: CrashSafeImage(
                color: firtsIconColor,
                firstIconPath ?? '',
                height: 20,
                width: 20,
              ),
            ),
            heightBox4,
            SizedBox(
              child: Text(
                firstName ?? '',

                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        FlowWidget(),
        Column(
          children: [
            CircleAvatar(
              backgroundColor: secondBgColor,
              radius: 25,
              child: CrashSafeImage(
                color: secondIconColor,
                secondIconPath ?? '',
                height: 20,
                width: 20,
              ),
            ),
            heightBox4,
            SizedBox(
              child: Text(
                secondName ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        FlowWidget(),
        Column(
          children: [
            CircleAvatar(
              backgroundColor: thirdBgColor,
              radius: 25,
              child: CrashSafeImage(
                thirdIconPath ?? '',
                height: 20,
                width: 20,
                color: thirdIconColor,
              ),
            ),
            heightBox16,
            SizedBox(
              child: Text(
                'Upload',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
