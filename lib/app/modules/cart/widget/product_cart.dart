import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 138,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 138,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.onboarding01.keyName),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              widthBox12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.location.keyName,
                              height: 12,
                            ),
                            widthBox8,
                            Text(
                              'Porto Alegre(RS)',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff595959),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Color(0xffEBF2EE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '2km',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox8,

                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      'Gucci greenly fully 6 set customized sofa available!',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.banana.keyName,
                              height: 16,
                            ),
                            widthBox8,
                            Text(
                              '(250)',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffBFA62C),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 26,
                          width: 77,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 10,
                                  child: Image.asset(
                                    height: 10,
                                    width: 10,
                                    Assets.images.minus.keyName,
                                  ),
                                ),
                                Text(
                                  '01',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 10,
                                  child: Image.asset(
                                    height: 10,
                                    width: 10,
                                    Assets.images.add.keyName,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
