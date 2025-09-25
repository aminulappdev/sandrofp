import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/modules/onboarding/widgets/info_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class OnboardingScreen03 extends StatefulWidget {
  const OnboardingScreen03({super.key});

  @override
  State<OnboardingScreen03> createState() => _OnboardingScreen03State();
}

class _OnboardingScreen03State extends State<OnboardingScreen03> {
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
            image: AssetImage(Assets.images.onboarding03.keyName),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height * 0.50,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        heightBox40,

                        SizedBox(
                          child: Text(
                            'Smarter alternative to our Sotroca!',
                            style: GoogleFonts.poppins(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
                        ),
                        heightBox30,
                        SizedBox(
                          child: Text(
                            'Saving up to 15% cost on Satroca.',
                            style: GoogleFonts.poppins(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CustomExpanded(),
                        CustomElevatedButton(
                          textColor: Colors.black,
                          title: 'Next',
                          color: AppColors.yellowColor,
                          onPress: () {
                            Get.to(() => const SignInScreen());
                          },
                        ),
                        heightBox50,
                      ],
                    ),
                  ),
                ),

                Positioned(left: 20, top: -80, child: InfoWidget()),
                Positioned(
                  left: 50,
                  top: -160,
                  child: Opacity(opacity: 0.4, child: InfoWidget()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpanded extends StatelessWidget {
  const CustomExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(height: 10));
  }
}
