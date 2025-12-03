// app/modules/product/views/edit_product_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/product/controller/edit_product_controller.dart';
import 'package:sandrofp/app/modules/product/widgets/label.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/image_picker_controller.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key});

  final List<String> _sizes = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'Free Size',
    '30',
    '32',
    '34',
    '36',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final categoryController = Get.find<CategoryController>();
    final imagePicker = ImagePickerHelper();

    String getCategoryName() {
      if (controller.selectedCategoryId.value.isEmpty) return 'Not Selected';
      final cat = categoryController.categoryData?.data.firstWhereOrNull(
        (c) => c.id == controller.selectedCategoryId.value,
      );
      return cat?.name ?? 'Unknown';
    }

    void showSizePicker() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Size",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox20,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _sizes.map((size) {
                final selected = controller.selectedSize.value == size;
                return GestureDetector(
                  onTap: () {
                    controller.selectedSize.value = size;
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? Colors.black : Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: selected ? Colors.black : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            heightBox30,
          ],
        ),
      ),
    );

    void showCategoryPicker() {
      final cats = categoryController.categoryData?.data ?? [];
      if (cats.isEmpty) {
        Get.snackbar("Error", "No categories available");
        return;
      }
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Category",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox20,
              Expanded(
                child: ListView.builder(
                  itemCount: cats.length,
                  itemBuilder: (_, i) {
                    final cat = cats[i];
                    final isSelected =
                        controller.selectedCategoryId.value == cat.id;
                    return ListTile(
                      onTap: () {
                        controller.selectedCategoryId.value = cat.id ?? '';
                        Get.back();
                      },
                      title: Text(cat.name ?? ''),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Product', leading: Container()),
      body: Obx(() {
        final allImages = controller.currentImagePaths;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox10,

              const Label(label: 'Name'), heightBox8,
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter product name',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox20,

              const Label(label: 'Description'), heightBox8,
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox20,

              const Label(label: 'Price'), heightBox8,
              TextFormField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter price',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox20,

              const Label(label: 'Discount (optional)'), heightBox8,
              TextFormField(
                controller: controller.discountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter discount',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox30,

              // const Label(label: 'Location'), heightBox8,
              // TextFormField(
              //   controller: controller.locationController,
              //   readOnly: true,
              //   decoration: const InputDecoration(
              //     hintText: 'Tap to select location',
              //     border: OutlineInputBorder(),
              //     suffixIcon: Icon(Icons.location_on_outlined),
              //   ),
              //   onTap: () =>
              //       Get.snackbar("Info", "Location picker coming soon!"),
              // ),
              // heightBox30,
              FeatureRow(
                title: 'Category:',
                widget: GestureDetector(
                  onTap: showCategoryPicker,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getCategoryName(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              heightBox10, const StraightLiner(), heightBox14,

              FeatureRow(
                title: 'Size:',
                widget: GestureDetector(
                  onTap: showSizePicker,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelData(
                        title: controller.selectedSize.value.isEmpty
                            ? 'Not set'
                            : controller.selectedSize.value,
                        bgColor: const Color(0xffF3F3F5),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              heightBox14, const StraightLiner(), heightBox20,

              const Label(label: 'Material'), heightBox8,
              TextFormField(
                controller: controller.materialController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Cotton, Leather',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox20,

              const Label(label: 'Color'), heightBox8,
              TextFormField(
                controller: controller.colorController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Black, Red',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox20,

              const Label(label: 'Quantity'), heightBox8,
              TextFormField(
                controller: controller.quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '1',
                  border: OutlineInputBorder(),
                ),
              ),
              heightBox30,

              Text(
                "Product Images",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox14,

              // Main Big Image
              if (allImages.isNotEmpty)
                Stack(
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: allImages.first.startsWith('http')
                              ? NetworkImage(allImages.first)
                              : FileImage(File(allImages.first))
                                    as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => controller.removeImage(allImages.first),
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text("No Image")),
                ),

              heightBox20,

              // Grid Images
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: allImages.length > 1 ? allImages.length - 1 : 0,
                itemBuilder: (_, i) {
                  final path = allImages[i + 1];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: path.startsWith('http')
                            ? Image.network(path, fit: BoxFit.cover)
                            : Image.file(File(path), fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(path),
                          child: const CircleAvatar(
                            radius: 12,
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
                },
              ),

              heightBox20,

              CustomElevatedButton(
                title: 'Add More Photos',
                color: Colors.transparent,
                textColor: Colors.black,
                borderColor: Colors.black,
                onPress: () => imagePicker.showMultiImagePicker(
                  context,
                  (file) => controller.addNewImage(file),
                ),
              ),

              heightBox30,

              Obx(
                () => CustomElevatedButton(
                  title: controller.isLoading.value
                      ? "Saving..."
                      : "Save Changes",
                  onPress: controller.isLoading.value
                      ? null
                      : controller.updateProduct,
                ),
              ),

              heightBox50,
            ],
          ),
        );
      }),
    );
  }
}
