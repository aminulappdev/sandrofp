
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/common/views/page_view.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding-screen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> buttonTexts = [
    ' Step Inside',
    ' Keep Reading',
    'Begin Your First Letter'
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          heightBox20,
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(
                () {
                  _currentPage = index;
                },
              );
            },
            children: [
              OnboardingPage(
                showBackButton: false,
                imageHeight: 300,
                onBoardingRow: false,
                title:
                    "Dear You,You hold so much.Your strength is quiet, your care is endless.",
                subtitle: "But who holds you?",
                pageController: _pageController,
              ),
              OnboardingPage(
                showBackButton: true,
                imageHeight: 280,
                onBoardingRow: true,
                title:
                    "This is your space to care, to be heard, to feel safe.",
                subtitle: "",
                pageController: _pageController, 
              ),
              OnboardingPage(
                showBackButton: true,
                imageHeight: 280,
                onBoardingRow: false,
                title: " You are safe here. You are seen. You are heard.",
                subtitle: "Welcome",
                pageController: _pageController, 
              ),
            ],
          ),
          // Positioned(
          //   bottom: 300.h,
          //   left: 0,
          //   right: 0,
          //   child: Column(
          //     children: [
          //       SmoothPageIndicator(
          //         controller: _pageController,
          //         count: 3,
          //         effect: WormEffect(
          //           dotHeight: 12.0.h,
          //           dotWidth: 12.0.w,
          //           spacing: 10.0,
          //           dotColor: Colors.grey,
          //           activeDotColor: Color(0xffD9A48E),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          
          Positioned(
            right: 0,
            left: 0,
            bottom: 50.h,
            child: Padding(
              padding:  EdgeInsets.all(15.0.h),
              child: GestureDetector(
                onTap: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                   
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      buttonTexts[_currentPage],
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, color: Color(0xffA074A0)),
                    ),
                    widthBox4,
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.iconButtonThemeColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
