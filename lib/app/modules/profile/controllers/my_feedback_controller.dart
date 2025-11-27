// app/modules/profile/controllers/my_feedback_controller.dart
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

  final RxBool isLoading = true.obs;

  // এই লাইনটা আছে বলেই আমরা পরে id চেঞ্জ করতে পারবো
  String sellerId = StorageUtil.getData(StorageUtil.userId) ?? '';

  @override
  void onInit() {
    super.onInit();
    getMyFeedback(); // প্রথমবার নিজের ফিডব্যাক লোড করে
  }

  Future<void> getMyFeedback() async {
    isLoading(true);
    try {
      final response = await _networkCaller.getRequest(
        Urls.myFeedbackUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        queryParams: {"seller": sellerId}, // এখানে যে id থাকবে সেই অনুযায়ী লোড হবে
      );

      if (response.isSuccess && response.responseData != null) {
        _myFeedbackModel.value = MyFeedbackModel.fromJson(response.responseData);
      } else {
        showError(response.errorMessage ?? "No feedback found");
        _myFeedbackModel.value = null;
      }
    } catch (e) {
      print("Feedback Error: $e");
      _myFeedbackModel.value = null;
    } finally {
      isLoading(false);
    }
  }
}