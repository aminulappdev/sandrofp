// app/modules/product/views/uplpad_product_description_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/product/controller/add_product_controller.dart';
import 'package:sandrofp/app/modules/product/widgets/label.dart';
import 'package:sandrofp/app/modules/product/widgets/status_bar.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class UploadProductDescriptionScreen extends GetView<AddProductController> {
  const UploadProductDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();
    final AddProductController controller = Get.find<AddProductController>();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product information',
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Form(
            key: _formKey,
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
                  thirdIconColor: Colors.grey,
                  thirdIconPath: Assets.images.group02.keyName,
                ),
                heightBox14,
                Text(
                  'Product Description',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                // === Size ===
                heightBox12,
                const Label(label: 'Size'),
                heightBox8,
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F3F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(
                      () => Row(
                        children: ['M', 'L', 'XL', 'XXL'].map((size) {
                          final isSelected =
                              controller.selectedSize.value == size;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: LabelData(
                              bgColor: isSelected
                                  ? AppColors.greenColor
                                  : Colors.white,
                              title: size,
                              onTap: () => controller.selectSize(size),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                // Obx(
                //   () => controller.selectedSize.value.isEmpty
                //       ? const Padding(
                //           padding: EdgeInsets.only(top: 8, left: 12),
                //           child: Text(
                //             'Please select a size',
                //             style: TextStyle(color: Colors.red, fontSize: 12),
                //           ),
                //         )
                //       : const SizedBox(),
                // ),

                // === Category ===
                heightBox12,
                const Label(label: 'Category'),
                heightBox8,
                Obx(() {
                  if (categoryController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (categoryController.categoryData == null ||
                      categoryController.categoryData!.data.isEmpty) {
                    return const Text('No categories found');
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Obx(
                          () => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: categoryController.categoryData!.data.map(
                              (cat) {
                                final isSelected =
                                    controller.selectedCategoryId.value ==
                                    cat.id;
                                return LabelData(
                                  bgColor: isSelected
                                      ? AppColors.greenColor
                                      : Colors.white,
                                  title: cat.name ?? '',
                                  onTap: () =>
                                      controller.selectCategory(cat.id!),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    );
                  }
                }),
                Obx(
                  () => controller.selectedCategoryId.value.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8, left: 12),
                          child: Text(
                            'Please select a category',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                      : const SizedBox(),
                ),

                // === Material ===
                heightBox12,
                const Label(label: 'Material'),
                heightBox8,
                TextFormField(
                  controller: controller.materialController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      ValidatorService.validateSimpleField(value),
                  decoration: const InputDecoration(
                    hintText: 'Enter your material',
                  ),
                ),

                // === Color ===
                heightBox12,
                const Label(label: 'Color'),
                heightBox8,
                TextFormField(
                  controller: controller.colorController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      ValidatorService.validateSimpleField(value),
                  decoration: const InputDecoration(
                    hintText: 'Enter product color',
                  ),
                ),

                // === Quantity ===
                heightBox12,
                const Label(label: 'Quantity'),
                heightBox8,
                TextFormField(
                  controller: controller.quantityController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      ValidatorService.validateSimpleField(value),
                  decoration: const InputDecoration(
                    hintText: 'Enter quantity (e.g. 10)',
                  ),
                ),

                heightBox20,
                CustomElevatedButton(
                  title: 'Next',
                  onPress: () {
                    if (_formKey.currentState!.validate() &&
                        controller.selectedCategoryId.value.isNotEmpty) {
                      controller.goToUploadFileScreen();
                    } else {
                      Get.snackbar(
                        'Validation Error',
                        'Please fill all required fields correctly',
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
      ),
    );
  }
}
