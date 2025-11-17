// app/modules/authentication/views/content_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import '../controller/content_controller.dart';

class ContentScreen extends GetView<ContentController> {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put the controller in the widget tree (GetX will create it automatically)
    return Scaffold(
      appBar: CustomAppBar(title: 'Terms of Service', leading: Container()),
      body: Obx(() {
        // -----------------------------------------------------------------
        // Loading overlay
        // -----------------------------------------------------------------
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.content.value.isNotEmpty) ...[
                  heightBox4,
                  Text(
                    controller.content.value,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ] else
                  const Text(
                    'No additional content available.',
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
