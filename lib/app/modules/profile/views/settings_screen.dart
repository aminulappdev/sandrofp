import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/profile/views/report_screen.dart';
import 'package:sandrofp/app/modules/profile/widgets/settings_header_widget.dart';
import 'package:sandrofp/app/modules/profile/widgets/settings_list_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/app_images/assets_path.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class SettingsScreen extends StatefulWidget {
  //final ProfileData? profileData;
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // final ContentController contentController = Get.put(ContentController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsHeader(imagePath: '', name: 'Md Aminul', onTap: () {}),
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
                    onTap: () {},
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.exHistory.keyName,
                    name: 'Exchange History',
                    onTap: () {},
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.lock.keyName,
                    name: 'Change Password',
                    onTap: () {},
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.help.keyName,
                    name: 'Help & Support',
                    onTap: () {
                      Get.to(const ReportScreen());
                    },
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.terms.keyName,
                    name: 'Terms of Service',
                    onTap: () {},
                  ),
                  heightBox16,

                  SettingItemList(
                    color: Color(0xffB50012),
                    iconData: Assets.images.delete.keyName,
                    iconSize: 16,
                    name: 'Delete account',
                    onTap: () {},
                  ),
                  heightBox16,
                  SettingItemList(
                    iconData: Assets.images.logOut.keyName,
                    name: 'Logout',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomDialog(
  //         yesText: 'Yes',
  //         noText: 'No',
  //         noOntap: () {
  //           Navigator.pop(context);
  //         },
  //         yesOntap: () {
  //           StorageUtil.deleteData(StorageUtil.userAccessToken);
  //           Get.offAll(SignInScreen());
  //         },
  //         iconData: Icons.delete,
  //         subtitle: '',
  //         title: 'Do you want to log out this profile?',
  //       );
  //     },
  //   );
  // }

  // void _showDeleteAccountDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomDialog(
  //         yesText: 'Yes',
  //         noText: 'No',
  //         noOntap: () {
  //           Navigator.pop(context);
  //         },
  //         yesOntap: () {
  //           Get.to(GrabbedConfirmedScreen());
  //         },
  //         iconData: Icons.delete,
  //         subtitle: '',
  //         title: 'Do you want to delete this profile?',
  //       );
  //     },
  //   );
  // }
}
