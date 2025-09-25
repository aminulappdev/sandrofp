import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/onboarding/views/onboarding_02.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class OnboardingScreen01 extends StatefulWidget {
  const OnboardingScreen01({super.key});

  @override
  State<OnboardingScreen01> createState() => _OnboardingScreen01State();
}

class _OnboardingScreen01State extends State<OnboardingScreen01> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.onboarding02.keyName),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                image: DecorationImage(
                  image: AssetImage(Assets.images.background.keyName),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    heightBox24,
                    CrashSafeImage(
                      Assets.images.banana.keyName,
                      width: 112,
                      height: 107,
                    ),
                    heightBox8,
                    CrashSafeImage(
                      Assets.images.text.keyName,
                      width: 186,
                      height: 46,
                    ),
                    heightBox10,
                    SizedBox(
                      child: Text(
                        'Swap your product get your more vibe',
                        style: GoogleFonts.poppins(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    heightBox10,
                    Text(
                      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomExpanded(),
                    CustomElevatedButton(
                      textColor: Colors.black,
                      title: 'Get Started',
                      color: AppColors.yellowColor,
                      onPress: () {
                        Get.to(
                          () => OnboardingScreen02(),
                          transition: Transition.rightToLeft, // Animation type
                        );
                      },
                    ),
                    heightBox30,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
