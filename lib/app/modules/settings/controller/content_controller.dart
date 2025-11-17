// app/modules/authentication/controller/content_controller.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ContentController extends GetxController {
  final RxBool isLoading = false.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  late String? token; // OTP token (optional)
  late String? title;
  final RxString content = ''.obs; // API response body

  @override
  void onInit() {
    super.onInit();
    // Get arguments from previous screen
    final args = Get.arguments as Map<String, dynamic>?;
    token = args?['data'] as String?;
    title = args?['title'] as String?;

    _fetchContent(token ?? '');
  }

  Future<void> _fetchContent(String key) async {
    try {
      isLoading(true);

      final response = await _networkCaller.getRequest(
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        Urls.contentUrl,
        queryParams: {"key": key},
      );

      if (response.isSuccess) {
        // Assuming the API returns a JSON with a field `content` (adjust if different)
        content.value = response.responseData['data'];
        showSuccess('Password changed successfully!');
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      debugPrint('Content Error: $e');
      showError('Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}
