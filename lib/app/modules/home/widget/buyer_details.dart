
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class BuyerDetails extends StatelessWidget {
  const BuyerDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffF3F3F5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        Assets.images.onboarding01.keyName,
                      ),
                      radius: 15,
                    ),
                    widthBox8,
                    Text(
                      'Aminul Islam',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CrashSafeImage(
                      Assets.images.brushSheld.keyName,
                      height: 24,
                    ),
                    widthBox4,
                    Text(
                      'Beginer',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            heightBox10,
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                CrashSafeImage(
                  Assets.images.star.keyName,
                  height: 24,
                ),
                widthBox4,
                Text(
                  '5.00 (20 Reviews)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            heightBox10,
            Text(
              'Lorem ipsum dolor sit amet, consectetur our adipiscing elit. Maecenas hendrerit luctus libero accused vulputate...',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            heightBox10,
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: CustomElevatedButton(
                    color: Colors.transparent,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    title: 'View profile',
                    onPress: () {},
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: CustomElevatedButton(
                    color: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.white,
                    title: 'View profile',
                    onPress: () {},
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