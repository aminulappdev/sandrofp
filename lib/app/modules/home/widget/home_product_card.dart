import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart' show Assets;

class HomeProductCard extends StatelessWidget {
  final String? imagePath;
  final String? price;
  final String? discount;
  final String? ownerName;
  final String? profile;
  final String? rating;
  final String? address;
  final String? distance;
  final String? title;
  final String? description;

  final VoidCallback onTap;
  final VoidCallback? shareTap;
  final VoidCallback? reactTap;
  const HomeProductCard({
    super.key,
    required this.onTap,
    this.imagePath,
    this.price,
    this.discount,
    this.ownerName,
    this.profile,
    this.rating,
    this.address,
    this.distance,
    this.title,
    this.description,
    this.shareTap,
    this.reactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
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
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imagePath ?? ''),
                    fit: BoxFit.cover,
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
                                  'Verified',
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
                              '($price)',
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
                          width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xffFFF4C2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '($discount)',
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.lineThrough,
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
                              ownerName ?? '',
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
                              '$rating (5)',
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
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CrashSafeImage(
                                Assets.images.location.keyName,
                                height: 16,
                              ),
                              widthBox8,
                              SizedBox(
                                width: 140,
                                child: Text(
                                  maxLines: 2,
                                  address ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff595959),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xffEBF2EE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '$distance away',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightBox8,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    heightBox4,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        description ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
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
                            onPress: onTap,
                            color: Colors.black,
                            textColor: Colors.white,
                          ),
                        ),

                        // Row(
                        //   children: [
                        //     CircleIconWidget(
                        //       imagePath: Assets.images.share.keyName,
                        //       onTap: shareTap ?? () {},
                        //       radius: 20,
                        //       iconRadius: 16,
                        //       color: Color(0xffEBF2EE),
                        //     ),
                        //     widthBox8,
                        //     CircleIconWidget(
                        //       iconRadius: 20,
                        //       imagePath: Assets.images.heart.keyName,
                        //       onTap: reactTap ?? () {},
                        //       radius: 20,
                        //       color: Color(0xffFFE6E6),
                        //     ),
                        //   ],
                        // ),
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
