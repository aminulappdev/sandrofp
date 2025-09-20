import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart' show Assets;

class HomeProductCard extends StatelessWidget {
  final VoidCallback onTap;
  const HomeProductCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Container(
         
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.onboarding01.keyName),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 38,
                          width: 95,
                          decoration: BoxDecoration(
                            color: Color(0xffEBF2EE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CrashSafeImage(
                                  Assets.images.done02.keyName,
                                  height: 16,
                                  width: 16,
                                  color: AppColors.greenColor,
                                ),
                                widthBox8,
                                Text(
                                  'View all',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.greenColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.banana.keyName,
                              height: 24,
                            ),
                            widthBox8,
                            Text(
                              '(250)',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffBFA62C),
                              ),
                            ),
                            widthBox8,
                            CrashSafeImage(
                              Assets.images.label.keyName,
                              height: 24,
                            ),
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
                              '(20%)',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff998523),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Assets.images.star.keyName,
                              height: 20,
                            ),
                            widthBox4,
                            Text(
                              '4.5 (20)',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.location.keyName,
                              height: 16,
                            ),
                            widthBox8,
                            Text(
                              'Porto Alegre(RS)',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff595959),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
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
                                '2km away',
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
                      'Gucci green fully 6 set customized sofa available!',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox8,
                    Text(
                      'Lorem ipsum dolor sit am connecter our adipescent elite. Maecenas herderite cultus libero accused...',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    heightBox12,
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 45,
                          width: 150,
                          child: CustomElevatedButton(
                            title: 'View Details',
                            onPress: () {},
                            color: Colors.black,
                            textColor: Colors.white,
                          ),
                        ),
        
                        Row(
                          children: [
                            CircleIconWidget(
                              imagePath: Assets.images.share.keyName,
                              onTap: () {},
                              radius: 20,
                              iconRadius: 16,
                              color: Color(0xffEBF2EE),
                            ),
                            widthBox8,
                            CircleIconWidget(
                              iconRadius: 20,
                              imagePath: Assets.images.heart.keyName,
                              onTap: () {},
                              radius: 20,
                              color: Color(0xffFFE6E6),
                            ),
                          ],
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
