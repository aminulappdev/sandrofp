// app/modules/authentication/controller/content_controller.dart
// অথবা যেখানে আছে সেখানে

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ContentController extends GetxController {
  final RxBool isLoading = false.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  late String? token;
  late String? title;
  final RxString content = ''.obs; // এটা সবসময় String থাকবে

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    token = args?['data'] as String?;
    title = args?['title'] as String?;

    fetchContent(token ?? '');
  }

  Future<void> fetchContent(String key) async {
    try {
      isLoading(true);

      final response = await _networkCaller.getRequest(
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        Urls.contentUrl,
        queryParams: {"key": key},
      );

      if (response.isSuccess) {
        final dynamic data = response.responseData['data'];

        if (data == null) {
          content.value = '';
        } else if (data is String) {
          content.value = data;
        } else if (data is num) {
          content.value = data.toString();
        } else if (data is Map<String, dynamic>) {
          final price = data['perTokenPrice'];
          content.value = price?.toString() ?? '';
        } else {
          content.value = data.toString();
        }

        if (key != 'perTokenPrice') {}
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      debugPrint('Content Error: $e');
      showError('Something went wrong');
      content.value = '';
    } finally {
      isLoading(false);
    }
  }
}
