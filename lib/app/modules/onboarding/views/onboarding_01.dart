import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
              height: 428,
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
                    heightBox24,
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
                    heightBox20,
                    CustomElevatedButton(
                      title: 'Get Started',
                      color: Colors.amber,
                      onPress: () {},
                    ),
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
