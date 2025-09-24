import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/others/views/feedback_completed.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class FeedbackScreen extends StatefulWidget {
  //final ProfileData? profileData;
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your feedback matters',
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'It takes less than 60 seconds to complete',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.profileData,
              ),
            ),
            heightBox16,
            Text(
              'Communication skills',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            Row(
              children: [
                CrashSafeImage(Assets.images.star.keyName, height: 30),
                CrashSafeImage(Assets.images.star.keyName, height: 30),
                CrashSafeImage(Assets.images.star.keyName, height: 30),
              ],
            ),
            heightBox16,
            Text(
              'Exchanger behavior',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            Row(
              children: [
                CrashSafeImage(Assets.images.star.keyName, height: 30),
                CrashSafeImage(Assets.images.star.keyName, height: 30),
                CrashSafeImage(Assets.images.star.keyName, height: 30),
              ],
            ),

            heightBox40,
            Text(
              'What did you think?',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            heightBox14,
            Row(
              children: [
                Container(
                  height: 27,

                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 216, 216),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CrashSafeImage(
                            Assets.images.done.keyName,
                            height: 14,
                          ),
                          widthBox4,
                          Text(
                            'Good',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                widthBox12,
                Container(
                  height: 27,

                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 216, 216),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CrashSafeImage(
                            Assets.images.done.keyName,
                            height: 14,
                          ),
                          widthBox4,
                          Text(
                            'Good',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                heightBox10,
              ],
            ),
            heightBox40,
            Text(
              'Your feedback matters',
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'It takes less than 60 seconds to complete',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.profileData,
              ),
            ),
            heightBox10,
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(hintText: 'Write your feedback'),
            ),
            heightBox12,
            CustomElevatedButton(title: 'Submit', onPress: () {
              Get.to(() => FeedbackCompletedScreen());
            }),
          ],
        ),
      ),
    );
  }
}
