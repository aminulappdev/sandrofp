import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/profile/views/report_submit_screen.dart';
import 'package:sandrofp/app/modules/profile/widgets/settings_list_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ReportScreen extends StatefulWidget {
  //final ProfileData? profileData;
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  

  @override 
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Report', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report an issue',
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
                    name: 'Fake product',
                    onTap: () {
                      Get.to(() => ReportSubmitScreen());
                    },
                  ),
                  heightBox16,
                  SettingItemList(name: 'Cheater exchanger', onTap: () {}),
                  heightBox16,
                  SettingItemList(name: 'Reject product', onTap: () {}),
                  heightBox16,
                  SettingItemList(name: 'Product problem', onTap: () {}),
                  heightBox16,
                  SettingItemList(name: 'Product problem', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
