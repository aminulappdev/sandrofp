// app/modules/home/views/filter_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/controller/filter_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  final List<String> sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> colors = const [
    'Black', 'White', 'Red', 'Blue', 'Green', 'Yellow', 'Gray', 'Pink',
  ];

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());
    final categoryController = Get.find<CategoryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Filter", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => filterController.clearFilters(),
            child: const Text("Clear", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================== CATEGORY SECTION ====================
            Text("Category", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            heightBox10,

            Obx(() {
              final categories = categoryController.categoryData?.data ?? [];
              final selectedCatId = filterController.selectedCategoryId.value;

              // Debug: দেখি ক্যাটাগরি লোড হয়েছে কিনা
              if (categories.isEmpty) {
                return const Text("No categories found");
              }

              return Wrap(
                spacing: 10,
                runSpacing: 12,
                children: [
                  // All Categories
                  _buildFilterChip(
                    label: "All",
                    isSelected: selectedCatId.isEmpty,
                    onTap: () {
                      filterController.selectedCategoryId.value = '';
                      debugPrint("Selected: All Categories");
                    },
                  ),

                  // Dynamic Categories from API
                  ...categories.map((cat) {
                    final String catId = cat.id.toString();  // int হলেও String হয়ে যাবে
                    final String catName = cat.name ?? "No Name";

                    return _buildFilterChip(
                      label: catName,
                      isSelected: selectedCatId == catId,
                      onTap: () {
                        filterController.selectedCategoryId.value = catId;
                        debugPrint("Selected Category → ID: $catId | Name: $catName");
                      },
                    );
                  }).toList(),
                ],
              );
            }),
            heightBox30,

            // ==================== COLOR SECTION ====================
            Text("Color", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            heightBox10,

            Obx(() {
              final selectedColor = filterController.selectedColor.value;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildFilterChip(
                    label: "All",
                    isSelected: selectedColor.isEmpty,
                    onTap: () {
                      filterController.selectedColor.value = '';
                      debugPrint("Selected Color: All");
                    },
                  ),
                  ...colors.map((color) => _buildFilterChip(
                    label: color,
                    isSelected: selectedColor == color,
                    onTap: () {
                      filterController.selectedColor.value = color;
                      debugPrint("Selected Color: $color");
                    },
                  )),
                ],
              );
            }),
            heightBox30,

            // ==================== SIZE SECTION ====================
            Text("Size", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            heightBox10,

            Obx(() {
              final selectedSize = filterController.selectedSize.value;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildFilterChip(
                    label: "All",
                    isSelected: selectedSize.isEmpty,
                    onTap: () {
                      filterController.selectedSize.value = '';
                      debugPrint("Selected Size: All");
                    },
                  ),
                  ...sizes.map((size) => _buildFilterChip(
                    label: size,
                    isSelected: selectedSize == size,
                    onTap: () {
                      filterController.selectedSize.value = size;
                      debugPrint("Selected Size: $size");
                    },
                  )),
                ],
              );
            }),
            heightBox40,

            // ==================== APPLY BUTTON ====================
            CustomElevatedButton(
              title: "Apply Filter",
              onPress: () {
                filterController.applyFilter();
              },
            ),
            heightBox20,
          ],
        ),
      ),
    );
  }

  // Reusable Chip
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        backgroundColor: isSelected ? Colors.black : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: isSelected ? Colors.black : Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}