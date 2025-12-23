// app/modules/product_details/views/product_details_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/home/widget/product_static_data.dart';
import 'package:sandrofp/app/modules/product/controller/add_product_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'dart:io';

class UploadProductDetailsScreen extends GetView<AddProductController> {
  const UploadProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();
    final categoryController = Get.find<CategoryController>();
    final product = controller.product;

    if (product == null) {
      return const Scaffold(body: Center(child: Text('No product data')));
    }

    // Selected Category Name
    String getSelectedCategoryName() {
      if (controller.selectedCategoryId.value.isEmpty) return 'N/A';
      final selectedCat = categoryController.categoryData?.data
          .firstWhereOrNull((cat) => cat.id == controller.selectedCategoryId.value);
      return selectedCat?.name ?? 'Unknown';
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Back', leading: Container()),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox12,

                    // Main Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: product.images.isNotEmpty
                          ? Image.file(
                              File(product.images.first.url),
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 220,
                              color: Colors.grey[300],
                              child: const Center(child: Text('No Image')),
                            ),
                    ),
                    heightBox12,

                    // Thumbnail Images
                    if (product.images.length > 1)
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.images.length - 1,
                          itemBuilder: (context, index) {
                            final img = product.images[index + 1];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(img.url),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    heightBox10,

                    ProductStaticData(
                      title: product.name,
                      price: (product.price).toStringAsFixed(2),
                      address: controller.selectedAddress.value,
                      description: product.descriptions,
                      discount: product.discount.toStringAsFixed(2),
                    ),
                    heightBox20,

                    Text(
                      'Product Details',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox10,

                    // === Conditional Feature Rows ===

                    // Size - শুধু দেখাবে যদি selectedSize non-empty
                    if (controller.selectedSize.value.isNotEmpty) ...[
                      FeatureRow(
                        title: 'Size:',
                        widget: LabelData(
                          onTap: () {},
                          bgColor: const Color(0xffF3F3F5),
                          title: controller.selectedSize.value,
                          titleColor: Colors.black,
                        ),
                      ),
                      heightBox20,
                      const StraightLiner(),
                      heightBox10,
                    ],

                    // Material - শুধু দেখাবে যদি material non-empty
                    if (product.brands.isNotEmpty) ...[
                      FeatureRow(
                        title: 'Material:',
                        widget: LabelData(
                          onTap: () {},
                          bgColor: const Color(0xffF3F3F5),
                          title: product.brands,
                          titleColor: Colors.black,
                        ),
                      ),
                      heightBox20,
                      const StraightLiner(),
                      heightBox10,
                    ],

                    // Category - সবসময় দেখাবে (required)
                    Obx(() {
                      final categoryName = getSelectedCategoryName();
                      return Column(
                        children: [
                          FeatureRow(
                            title: 'Category:',
                            widget: Text(
                              categoryName,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff595959),
                              ),
                            ),
                          ),
                          heightBox20,
                          const StraightLiner(),
                          heightBox10,
                        ],
                      );
                    }),

                    // Color - শুধু দেখাবে যদি color non-empty
                    if (product.colors.isNotEmpty) ...[
                      FeatureRow(
                        title: 'Color:',
                        widget: LabelData(
                          onTap: () {},
                          bgColor: const Color(0xffF3F3F5),
                          title: product.colors,
                          titleColor: Colors.black,
                        ),
                      ),
                      heightBox20,
                      const StraightLiner(),
                      heightBox10,
                    ],

                    // Quantity - শুধু দেখাবে যদি quantity > 0 বা text non-empty
                    if (controller.quantityController.text.trim().isNotEmpty) ...[
                      FeatureRow(
                        title: 'Quantity:',
                        widget: Text(
                          controller.quantityController.text.trim(),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff595959),
                          ),
                        ),
                      ),
                      heightBox20,
                      const StraightLiner(),
                      heightBox10,
                    ],

                    // Delivery Policy - সবসময় দেখাবে
                    FeatureRow(
                      title: 'Delivery Policy:',
                      widget: Text(
                        'Within 2 working days',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff595959),
                        ),
                      ),
                    ),
                    heightBox20,
                    const StraightLiner(),
                    heightBox30,
                  ],
                ),
              ),
            ),
          ),

          // Bottom Upload Button
          Card(
            elevation: 3,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      color: AppColors.greenColor,
                      textColor: Colors.white,
                      title: 'Upload Product',
                      onPress: controller.uploadProduct,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}