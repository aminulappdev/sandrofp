import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/product/widgets/label.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ReportSubmitScreen extends StatefulWidget { 
  //final ProfileData? profileData;
  const ReportSubmitScreen({super.key});

  @override
  State<ReportSubmitScreen> createState() => _ReportSubmitScreenState();
}

class _ReportSubmitScreenState extends State<ReportSubmitScreen> {
 

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
        child: SingleChildScrollView(
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
              Label(label: 'Fake product'),
              heightBox10,
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade200,
                ),
                child: Center(
                  child: CrashSafeImage(
                    Assets.images.gallery.keyName,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              heightBox20,
              Label(label: 'Fake product'),
              heightBox10,
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(hintText: 'Enter your report'),
              ),
              heightBox16,
              CustomElevatedButton(title: 'Submit', onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
