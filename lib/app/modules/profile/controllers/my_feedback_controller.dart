// lib/app/modules/product/controller/all_product_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/model/my_seller_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class MyFeedbackController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<MyFeedbackModel?> _myFeedbackModel = Rx<MyFeedbackModel?>(null);
  List<MyFeedbackItemModel> get myFeedbackItems =>
      _myFeedbackModel.value?.data?.data ?? [];

  // লোডিং স্টেট
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getMyFeedback();
  }

  // API কল
  Future<void> getMyFeedback() async {
    isLoading(true);
    try {
      final response = await _networkCaller.getRequest(
        Urls.myFeedbackUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        queryParams: {"seller": StorageUtil.getData(StorageUtil.userId)},
        // queryParams: {"seller": '6918182fa7f19a573dad8d91'},
      );

      if (response.isSuccess && response.responseData != null) {
        _myFeedbackModel.value = MyFeedbackModel.fromJson(
          response.responseData,
        );
      } else {
        showError(response.errorMessage);
        _myFeedbackModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _myFeedbackModel.value = null;
    } finally {
      isLoading(false);
    }
  }
}
