import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/home/model/category_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class CategoryController extends GetxController {
  final RxBool obscureText = true.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<CategoryModel?> _categoryModel = Rx<CategoryModel?>(null);
  CategoryData? get categoryData => _categoryModel.value?.data; 

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    isLoading(true);
    final response = await _networkCaller.getRequest(
      Urls.categoryUrl,
      accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );
    isLoading(false);
    if (response.isSuccess) {
      final data = response.responseData['data'];
      if (data != null) {
        _categoryModel.value = CategoryModel.fromJson(response.responseData);
      } else {}
    } else {
      showError(response.errorMessage);
    }
  }
}
