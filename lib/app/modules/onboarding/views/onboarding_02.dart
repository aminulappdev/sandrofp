import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/onboarding/views/onboarding_03.dart';
import 'package:sandrofp/app/modules/onboarding/widgets/info_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class OnboardingScreen02 extends StatefulWidget {
  const OnboardingScreen02({super.key});

  @override
  State<OnboardingScreen02> createState() => _OnboardingScreen02State();
}

class _OnboardingScreen02State extends State<OnboardingScreen02> {
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
            image: AssetImage(Assets.images.onboarding01.keyName),
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
                  height: height * 0.55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.backgroundEarth.keyName),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        heightBox100,
                        heightBox20,

                        SizedBox(
                          child: Text(
                            'Register & join andcommunity of over 9,000+ users.',
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
                          title: 'Next',
                          color: AppColors.yellowColor,
                          onPress: () {
                             Get.to(() => OnboardingScreen03(), transition: Transition.rightToLeft);
                          },
                        ),
                        heightBox50,
                      ],
                    ),
                  ),
                ),

                Positioned(left: width * 0.18, top: -35, child: InfoWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpanded extends StatelessWidget {
  const CustomExpanded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(height: 10,));
  }
}
