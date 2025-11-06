import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/views/my_product_card_page.dart';
import 'package:sandrofp/app/modules/chat/views/chat_screen.dart';
import 'package:sandrofp/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:sandrofp/app/modules/home/views/home_screen.dart';
import 'package:sandrofp/app/modules/profile/views/profile_screen.dart';
import 'package:sandrofp/app/modules/settings/views/settings_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => CircleNavBar(
          activeIcons: _activeIcons,
          inactiveIcons: _inactiveIcons,
          circleColor: AppColors.yellowColor,
          color: const Color(0xff204C33),
          height: 85,
          circleWidth: 70,
          activeIndex: controller.tabIndex,
          onTap: controller.changeTab,
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          elevation: 0,
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MyProductCardScreen(),
          ChatListScreen(),
          HomeScreen(),
          SettingsScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }

  // ---------- Active Icons ----------
  List<Widget> get _activeIcons => [
    _icon(Assets.images.heart03, AppColors.greenColor),
    _icon(Assets.images.sms, AppColors.greenColor),
    _icon(Assets.images.home, AppColors.greenColor),
    _icon(Assets.images.settings, AppColors.greenColor),
    _icon(Assets.images.person02, AppColors.greenColor),
  ];

  // ---------- Inactive Icons ----------
  List<Widget> get _inactiveIcons => [
    _labeledIcon(Assets.images.heart03, "Wishlist"),
    _labeledIcon(Assets.images.sms, "Message"),
    _labeledIcon(Assets.images.home, "Home", active: true),
    _labeledIcon(Assets.images.settings, "Settings"),
    _labeledIcon(Assets.images.person02, "Profile"),
  ];

  Widget _icon(AssetGenImage asset, Color color) => Padding(
    padding: const EdgeInsets.all(18.0),
    child: CrashSafeImage(asset.keyName, height: 20, width: 20, color: color),
  );

  Widget _labeledIcon(
    AssetGenImage asset,
    String label, {
    bool active = false,
  }) => Column(
    children: [
      CrashSafeImage(
        asset.keyName,
        height: 20,
        width: 20,
        color: active ? Colors.white : null,
      ),
      heightBox4,
      Text(
        label,
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
      ),
    ],
  );
}
