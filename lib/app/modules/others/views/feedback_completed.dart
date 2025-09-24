import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/others/views/feedback_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class FeedbackCompletedScreen extends StatefulWidget {
  //final ProfileData? profileData;
  const FeedbackCompletedScreen({super.key});

  @override
  State<FeedbackCompletedScreen> createState() =>
      _FeedbackCompletedScreenState();
}

class _FeedbackCompletedScreenState extends State<FeedbackCompletedScreen> {
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
              'Your feedback has been given',
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Lorem Ipsum simply random text. It has roots in classical from making it over years old.',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.profileData,
              ),
              textAlign: TextAlign.center,
            ),
            heightBox16,
            SizedBox(
             
              child: CustomElevatedButton(
                title: 'Go Home',
                onPress: () {
                  Get.to(() => const FeedbackScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
