import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
    // প্রতিবার নতুন ইন্সট্যান্স তৈরি করা হচ্ছে (পুরোনোটা onClose-এ ডিলিট হয়ে যাবে)
    Get.put(ContentController());

    return Scaffold(
      appBar: CustomAppBar(
        title: controller.title.value, // ডাইনামিক টাইটেল (arguments থেকে আসবে)
        leading: Container(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.content.value.isEmpty) {
          return const Center(
            child: Text(
              'No additional content available.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox4,
                Html(data: controller.content.value),
              ],
            ),
          ),
        );
      }),
    );
  }
}