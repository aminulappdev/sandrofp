// app/modules/product/views/upload_file_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/product/controller/add_product_controller.dart';
import 'package:sandrofp/app/modules/product/widgets/status_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/image_picker_controller.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class UploadProductFileScreen extends GetView<AddProductController> {
  const UploadProductFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();
    final imagePickerHelper = ImagePickerHelper();

    return Scaffold(
      appBar: CustomAppBar(title: 'Upload Product', leading: Container()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              heightBox12,
              StatusBar(
                firstName: 'Information',
                firstBgColor: const Color(0xffEBF2EE),
                firtsIconColor: null,
                firstIconPath: Assets.images.group02.keyName,
                secondName: 'Description',
                secondBgColor: const Color(0xffEBF2EE),
                secondIconColor: null,
                secondIconPath: Assets.images.group02.keyName,
                thirdName: 'Upload',
                thirdBgColor: const Color(0xffEBF2EE),
                thirdIconColor: null,
                thirdIconPath: Assets.images.group02.keyName,
              ),
              heightBox14,
              Text(
                'Product image',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox4,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              // === BIG IMAGE ===
              heightBox12,
              Obx(() {
                if (controller.selectedImages.isNotEmpty) {
                  return Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: FileImage(controller.selectedImages.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(
                            controller.selectedImages.first,
                          ),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Please select at least one image',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  );
                }
              }),

              heightBox10,
              Text(
                'Image should be 380* 200*',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffFF0000),
                ),
              ),

              // === Small Image Grid ===
              heightBox20,
              Obx(() {
                final remainingImages = controller.selectedImages.length > 1
                    ? controller.selectedImages.sublist(1)
                    : <File>[];
                if (remainingImages.isEmpty) return const SizedBox();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: remainingImages.length,
                  itemBuilder: (context, index) {
                    final image = remainingImages[index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            image,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => controller.removeImage(image),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black54,
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),

              heightBox20,
              CustomElevatedButton(
                color: Colors.transparent,
                textColor: Colors.black,
                borderColor: Colors.black,
                title: 'Add more photos',
                onPress: () {
                  imagePickerHelper.showMultiImagePicker(context, (file) {
                    controller.addImage(file);
                  });
                },
              ),

              heightBox20,
              CustomElevatedButton(
                title: 'Next',
                onPress: () {
                  if (controller.selectedImages.isNotEmpty) {
                    controller.goToProductDetails();
                  } else {
                    Get.snackbar(
                      'Image Required',
                      'Please select at least one image',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
              heightBox20,
            ],
          ),
        ),
      ),
    );
  }
}
