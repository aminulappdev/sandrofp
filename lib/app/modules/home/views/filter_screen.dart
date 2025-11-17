import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/filter_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/category_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(FilterController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  CircleIconWidget(
                    imagePath: Assets.images.cross.path,
                    onTap: controller.closeFilter,
                  ),
                ],
              ),
              heightBox4,
              Text(
                'Please choose categories so that app can suggests you to find er appropriate products',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              heightBox20,
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Change',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              heightBox40,

              // Dynamic distance text
              Obx(
                () => Text(
                  '${controller.sliderValue.value.toStringAsFixed(1)}km',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),

              Obx(
                () => SfSlider(
                  activeColor: AppColors.greenColor,
                  min: 0.0,
                  max: 100.0,
                  value: controller.sliderValue.value,
                  interval: 20,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    controller.updateSlider(value);
                  },
                ),
              ),

              heightBox20,
              Text(
                'Categories',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Obx(
                () => Row(
                  children: [
                    CategoryWidget(
                      onTap: () => controller.selectCategory(0),
                      label: 'All',
                      bgColor: controller.selectedCategoryIndex.value == 0
                          ? Colors.black
                          : null,
                      textColor: controller.selectedCategoryIndex.value == 0
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCategory(1),
                      label: 'Furniture',
                      bgColor: controller.selectedCategoryIndex.value == 1
                          ? Colors.black
                          : null,
                      textColor: controller.selectedCategoryIndex.value == 1
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCategory(2),
                      label: 'Clothing',
                      bgColor: controller.selectedCategoryIndex.value == 2
                          ? Colors.black
                          : null,
                      textColor: controller.selectedCategoryIndex.value == 2
                          ? Colors.white
                          : null,
                    ),
                  ],
                ),
              ),

              heightBox20,
              StraightLiner(),
              heightBox20,

              Text(
                'Collection Type',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Obx(
                () => Row(
                  children: [
                    CategoryWidget(
                      onTap: () => controller.selectCollectionType(0),
                      label: 'All',
                      bgColor: controller.selectedCollectionTypeIndex.value == 0
                          ? Colors.black
                          : null,
                      textColor:
                          controller.selectedCollectionTypeIndex.value == 0
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCollectionType(1),
                      label: 'Men',
                      bgColor: controller.selectedCollectionTypeIndex.value == 1
                          ? Colors.black
                          : null,
                      textColor:
                          controller.selectedCollectionTypeIndex.value == 1
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCollectionType(2),
                      label: 'Women',
                      bgColor: controller.selectedCollectionTypeIndex.value == 2
                          ? Colors.black
                          : null,
                      textColor:
                          controller.selectedCollectionTypeIndex.value == 2
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCollectionType(3),
                      label: 'Other',
                      bgColor: controller.selectedCollectionTypeIndex.value == 3
                          ? Colors.black
                          : null,
                      textColor:
                          controller.selectedCollectionTypeIndex.value == 3
                          ? Colors.white
                          : null,
                    ),
                  ],
                ),
              ),

              heightBox20,
              StraightLiner(),
              heightBox20,

              Text(
                'Collection',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Obx(
                () => Row(
                  children: [
                    CategoryWidget(
                      onTap: () => controller.selectCollection(0),
                      label: 'All',
                      bgColor: controller.selectedCollectionIndex.value == 0
                          ? Colors.black
                          : null,
                      textColor: controller.selectedCollectionIndex.value == 0
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCollection(1),
                      label: 'Furniture',
                      bgColor: controller.selectedCollectionIndex.value == 1
                          ? Colors.black
                          : null,
                      textColor: controller.selectedCollectionIndex.value == 1
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectCollection(2),
                      label: 'Clothing',
                      bgColor: controller.selectedCollectionIndex.value == 2
                          ? Colors.black
                          : null,
                      textColor: controller.selectedCollectionIndex.value == 2
                          ? Colors.white
                          : null,
                    ),
                  ],
                ),
              ),

              heightBox20,
              StraightLiner(),
              heightBox20,

              Text(
                'Brand',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Obx(
                () => Row(
                  children: [
                    CategoryWidget(
                      onTap: () => controller.selectBrand(0),
                      label: 'All',
                      bgColor: controller.selectedBrandIndex.value == 0
                          ? Colors.black
                          : null,
                      textColor: controller.selectedBrandIndex.value == 0
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectBrand(1),
                      label: 'Men',
                      bgColor: controller.selectedBrandIndex.value == 1
                          ? Colors.black
                          : null,
                      textColor: controller.selectedBrandIndex.value == 1
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectBrand(2),
                      label: 'Women',
                      bgColor: controller.selectedBrandIndex.value == 2
                          ? Colors.black
                          : null,
                      textColor: controller.selectedBrandIndex.value == 2
                          ? Colors.white
                          : null,
                    ),
                    widthBox10,
                    CategoryWidget(
                      onTap: () => controller.selectBrand(3),
                      label: 'Other',
                      bgColor: controller.selectedBrandIndex.value == 3
                          ? Colors.black
                          : null,
                      textColor: controller.selectedBrandIndex.value == 3
                          ? Colors.white
                          : null,
                    ),
                  ],
                ),
              ),

              heightBox40,
              CustomElevatedButton(
                title: 'Filter',
                onPress: controller.applyFilter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
