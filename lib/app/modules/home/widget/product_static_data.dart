import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProductStaticData extends StatelessWidget {
  final String? price;
  final String? discount;
  final String? address;
  final String? title;
  final String? description;
  final String? distance;
  const ProductStaticData({
    super.key,
    this.price,
    this.discount,
    this.address,
    this.title,
    this.description,
    this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CrashSafeImage(Assets.images.banana.keyName, height: 22),
                widthBox8,
                Text(
                  '($price)',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffBFA62C),
                  ),
                ),
                widthBox8,
                CrashSafeImage(Assets.images.label.keyName, height: 22),
              ],
            ),
            Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                color: Color(0xffFFF4C2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '($discount)',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff998523),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ),
          ],
        ),

        heightBox10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CrashSafeImage(Assets.images.location.keyName, height: 16),
                widthBox8,
                SizedBox(
                  width: 200,
                  child: Text(
                    '$address',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff595959),
                    ),
                  ),
                ),
              ],
            ),
            distance == null
                ? Container()
                : InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 95,
                      decoration: BoxDecoration(
                        color: Color(0xffEBF2EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '$distance away',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        heightBox12,
        Text(
          '$title',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        heightBox8,
        Text(
          '$description',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          textAlign: TextAlign.justify,
        ),
        heightBox10,
        Container(
          height: 36,
          width: 260,
          decoration: BoxDecoration(
            color: Color(0xffFFF4C2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CrashSafeImage(Assets.images.banana.keyName, height: 22),
                widthBox8,
                Text(
                  'Fully banana exchange available',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff998523),
                  ),
                ),
              ],
            ),
          ),
        ),
        heightBox10,
        Container(
          height: 36,
          width: 320,
          decoration: BoxDecoration(
            color: Color(0xffEBF2EE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CrashSafeImage(Assets.images.done02.keyName, height: 22),
                widthBox8,
                Text(
                  'Protected with secure payment processing',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        heightBox10,
      ],
    );
  }
}
