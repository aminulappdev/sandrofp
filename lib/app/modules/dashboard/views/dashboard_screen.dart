import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/views/cart_screen.dart';
import 'package:sandrofp/app/modules/chat/views/chat_screen.dart';
import 'package:sandrofp/app/modules/home/views/home_screen.dart';
import 'package:sandrofp/app/modules/profile/views/profile_screen.dart';
import 'package:sandrofp/app/modules/profile/views/settings_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CrashSafeImage(
              Assets.images.heart03.keyName,
              height: 20,
              width: 20,
              color: AppColors.greenColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CrashSafeImage(
              Assets.images.sms.keyName,
              height: 20,
              width: 20,
              color: AppColors.greenColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CrashSafeImage(
              Assets.images.home.keyName,
              height: 20,
              width: 20,
              color: AppColors.greenColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CrashSafeImage(
              Assets.images.settings.keyName,
              height: 20,
              width: 20,
              color: AppColors.greenColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: CrashSafeImage(
              Assets.images.person02.keyName,
              height: 20,
              width: 20,
              color: AppColors.greenColor,
            ),
          ),
        ],

        inactiveIcons: [
          Column(
            children: [
              CrashSafeImage(
                Assets.images.heart03.keyName,
                height: 20,
                width: 20,
              ),
              heightBox4,
              Text(
                "Wishlist",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              CrashSafeImage(Assets.images.sms.keyName, height: 20, width: 20),
              heightBox4,
              Text(
                "Message",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              CrashSafeImage(
                Assets.images.home.keyName,
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              heightBox4,
              Text(
                "Home",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              CrashSafeImage(
                Assets.images.settings.keyName,
                height: 20,
                width: 20,
              ),
              heightBox4,
              Text(
                "Settings",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              CrashSafeImage(
                Assets.images.person02.keyName,
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              heightBox4,
              Text(
                "Profile",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ],
        circleColor: AppColors.yellowColor,
        color: Color(0xff204C33),
        height: 100,
        circleWidth: 70,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
        elevation: 0,
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(), // এই line টা add করুন
        children: [
          HomeScreen(),
          ChatListScreen(),
          HomeScreen(),
          SettingsScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}