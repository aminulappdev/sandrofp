import 'package:get/get.dart';

class FilterController extends GetxController {
  // Slider value
  var sliderValue = 50.0.obs;

  // Selected categories (example: index based selection)
  var selectedCategoryIndex = (-1).obs;
  var selectedCollectionTypeIndex = (-1).obs;
  var selectedCollectionIndex = (-1).obs;
  var selectedBrandIndex = (-1).obs;

  void updateSlider(double value) {
    sliderValue.value = value;
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void selectCollectionType(int index) {
    selectedCollectionTypeIndex.value = index;
  }

  void selectCollection(int index) {
    selectedCollectionIndex.value = index;
  }

  void selectBrand(int index) {
    selectedBrandIndex.value = index;
  }

  void applyFilter() {
    // TODO: Apply filter logic
    Get.back(result: {
      'distance': sliderValue.value,
      'category': selectedCategoryIndex.value,
      // Add others as needed
    });
  }

  void closeFilter() {
    Get.back();
  }
}