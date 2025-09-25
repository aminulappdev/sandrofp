import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/common/views/feedback_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangedCompletedScreen extends StatefulWidget {
  //final ProfileData? profileData;
  const ExchangedCompletedScreen({super.key});

  @override
  State<ExchangedCompletedScreen> createState() =>
      _ExchangedCompletedScreenState();
}

class _ExchangedCompletedScreenState extends State<ExchangedCompletedScreen> {
  // final ContentController contentController = Get.put(ContentController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Completed', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            heightBox100,
            CrashSafeImage(
              Assets.images.avatur02.keyName,
              height: 200,
              width: 200,
            ),
            heightBox16,
            Text(
              'Product exchange successfully completed',
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'There are many variations of passages of Lorem Ipsum available but suffered alteration.',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.profileData,
              ),
              textAlign: TextAlign.center,
            ),
            heightBox16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 170.w,
                  child: CustomElevatedButton(
                    color: Colors.transparent,
                    textColor: AppColors.greenColor,
                    borderColor: AppColors.greenColor,
                    title: 'Go Home',
                    onPress: () {},
                  ),
                ),
                widthBox10,
                SizedBox(
                  width: 170.w,
                  child: CustomElevatedButton(
                    title: 'Leave feedback',
                    onPress: () {
                      Get.to(() => const FeedbackScreen());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
