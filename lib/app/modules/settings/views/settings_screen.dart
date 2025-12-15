import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/modules/profile/views/profile_screen.dart';
import 'package:sandrofp/app/modules/settings/views/change_password_screen.dart';
import 'package:sandrofp/app/modules/settings/views/content_screen.dart';
import 'package:sandrofp/app/modules/settings/views/exchange_history_screen.dart';
import 'package:sandrofp/app/modules/profile/widgets/settings_header_widget.dart';
import 'package:sandrofp/app/modules/profile/widgets/settings_list_widget.dart';
import 'package:sandrofp/app/modules/settings/views/token_exchange_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_dialog.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class SettingsScreen extends StatefulWidget {
  //final ProfileData? profileData;
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        leading: Container(),
        isBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (profileController.isLoading.value) {
                  return SettingsHeader(
                    imagePath: '',
                    name: '',
                    onTap: () {},
                    rating: '',
                  );
                } else {
                  return SettingsHeader(
                    imagePath: profileController.profileData?.profile ?? '',
                    name: profileController.profileData?.name ?? '',
                    rating:
                        profileController.profileData?.tokens.toString() ?? '',
                    onTap: () {
                      Get.to(() => ProfileScreen());
                    },
                  );
                }
              }),
              heightBox30,
              Text(
                'Other options',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                'There are many variations of passages of Lorem Ipsum available but suffered alteration.',
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.profileData,
                ),
              ),
              heightBox20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingItemList(
                    iconData: Assets.images.exchange.keyName,
                    name: 'Token exchange',
                    onTap: () {
                      Get.to(() => const TokenExchangeScreen());
                    },
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.exHistory.keyName,
                    name: 'Exchange History',
                    onTap: () {
                      Get.to(() => const ExchangeHistoryScreen());
                    },
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.lock.keyName,
                    name: 'Change Password',
                    onTap: () {
                      Get.to(() => const ChangePasswordScreen(email: ''));
                    },
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.help.keyName,
                    name: 'Help & Support',
                    onTap: () {
                      Get.to(
                        ContentScreen(),
                        arguments: {
                          'title': 'Help & Support',
                          'key': 'aboutUs',
                        },
                      );
                    },
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.terms.keyName,
                    name: 'Terms of Service',
                    onTap: () {
                      Get.to(
                        () =>
                            ContentScreen(), // ফাংশন হিসেবে দাও (খুব গুরুত্বপূর্ণ!)
                        arguments: {
                          'title': 'Terms of Service',
                          'key': 'termsAndConditions',
                        },
                      );
                    },
                  ),
                  // heightBox16,

                  // SettingItemList(
                  //   color: Color(0xffB50012),
                  //   iconData: Assets.images.delete.keyName,
                  //   iconSize: 16,
                  //   name: 'Delete account',
                  //   onTap: () {},
                  // ),
                  heightBox16,
                  SettingItemList(
                    color: Color.fromARGB(255, 212, 67, 81),
                    iconData: Assets.images.logOut.keyName,
                    name: 'Logout',
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  heightBox100,
                  heightBox100,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          yesText: 'Yes',
          noText: 'No',
          noOntap: () {
            Navigator.pop(context);
          },
          yesOntap: () {
            StorageUtil.deleteData(StorageUtil.userAccessToken);
            StorageUtil.deleteData(StorageUtil.userId);
            Get.offAll(() => const SignInScreen());
          },
          iconData: Icons.delete,
          subtitle: '',
          title: 'Do you want to log out this profile?',
        );
      },
    );
  }
}
