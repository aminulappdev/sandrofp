
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool onBoardingRow;
  final bool showBackButton;
  final double imageHeight;
  final PageController pageController; 

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBoardingRow,
    required this.imageHeight,
    required this.showBackButton,
    required this.pageController, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightBox24,
            Visibility(
              visible: !showBackButton,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {          
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(162, 243, 213, 248),
                      radius: 24.r,
                      backgroundImage: AssetImage(Assets.images.arrowBack.keyName),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: AppColors.iconButtonThemeColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                      
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: AppColors.iconButtonThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            heightBox100,
            heightBox24,
            Text(
                title,
                style: TextStyle(
                    fontFamily: 'Cormorant Garamond', fontSize: 40.sp),
                textAlign: TextAlign.center,
              ),
        
            heightBox12,
            Visibility(
              visible: !onBoardingRow,
              // replacement: BulletPointsWidget(),
              child: Text(
                subtitle,
                style: TextStyle(
                    fontFamily: 'Flatlion Personal', fontSize: 60.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
