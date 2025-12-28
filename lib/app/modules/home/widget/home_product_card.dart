import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                      color: Colors.grey[300],
                      image: imagePath != null && imagePath!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(imagePath!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: imagePath == null || imagePath!.isEmpty
                        ? const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 50,
                          )
                        : null,
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 38,
                        width: 95,
                        decoration: BoxDecoration(
                          color: const Color(0xffEBF2EE),
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
                  ),
                ],
              ),
              
              // Content section
              Padding(
                padding:  EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price and discount row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.banana.keyName,
                              height: 24.h,
                            ),
                            widthBox8,
                            Text(
                              price ?? '\$0',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffBFA62C),
                              ),
                            ),
                            widthBox8,
                            CrashSafeImage(
                              Assets.images.label.keyName,
                              height: 24.h,
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF4C2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              discount ?? '\$0',
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff998523),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    heightBox12,
                    
                    // Owner and rating row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: profile != null && profile!.isNotEmpty
                                  ? NetworkImage(profile!)
                                  : AssetImage(Assets.images.onboarding01.keyName) as ImageProvider,
                              radius: 15,
                            ),
                            widthBox8,
                            SizedBox(
                              width: 100,
                              child: Text(
                                ownerName ?? 'Unknown',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
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
                    
                    // Address and distance row
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
                                  address ?? 'Address not available',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff595959),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          distance == null || distance == '' ? const SizedBox.shrink() :  Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xffEBF2EE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
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
                          ),
                        ],
                      ),
                    ),
                    
                    heightBox8,
                    
                    // Title
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        title ?? 'No Title',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    
                    heightBox4,
                    
                    // Description
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        description ?? 'No description available',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    
                    heightBox12,
                    
                    // View Details button
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: 150,
                      child: CustomElevatedButton(
                        title: 'View Details',
                        onPress: onTap,
                        color: Colors.black,
                        textColor: Colors.white,
                      ),
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