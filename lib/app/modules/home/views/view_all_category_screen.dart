import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/views/view_all_item_screen.dart';
import 'package:sandrofp/app/modules/home/widget/category_image.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ViewAllCategoryScreen extends GetView<CategoryController> {
  const ViewAllCategoryScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Category', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Furniture items',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            heightBox8,
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.categoryData?.data.isEmpty ?? false) {
                return const Center(
                  child: Text(
                    "No category yet",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: controller.categoryData?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: CategoryImage(
                          name: controller.categoryData?.data[index].name ?? '',
                          imagePath:
                              controller.categoryData?.data[index].banner ?? '',
                          onTap: () {
                            Get.to(
                              () => const ViewAllItemScreen(),
                              arguments: {
                                'title':
                                    controller.categoryData?.data[index].name,
                                'category':
                                    controller.categoryData?.data[index].id,
                                'type': 'category',
                              },
                            );
                          },
                          height: 150,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
