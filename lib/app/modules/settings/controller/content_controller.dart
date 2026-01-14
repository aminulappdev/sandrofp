import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ContentController extends GetxController {
  final RxBool isLoading = false.obs; 
  final NetworkCaller _networkCaller = NetworkCaller();

  final RxString title = 'Content'.obs;
  final RxString content = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArgumentsAndFetch(); // শুধু ContentScreen-এর জন্য কাজ করবে
  }

  @override
  void onReady() {
    super.onReady();
    if (content.value.isEmpty && title.value == 'Content') {
      _loadArgumentsAndFetch();
    }
  }

  // ContentScreen-এর জন্য — arguments থেকে fetch
  void _loadArgumentsAndFetch() {
    final args = Get.arguments as Map<String, dynamic>?;

    // যদি arguments না থাকে (যেমন TokenExchangeScreen থেকে direct call), তাহলে error দেখাবো না
    if (args == null) {
      debugPrint('⚠️ No arguments provided. Skipping load from arguments.');
      return;
    }

    debugPrint('🔍 Received arguments: $args');

    final String pageTitle = args['title'] ?? 'Content';
    final String contentKey = args['key'] ?? args['data'] ?? '';

    title.value = pageTitle;

    if (contentKey.isEmpty) {
      content.value = 'Invalid content key.';
      showError('No content key provided');
      return;
    }

    debugPrint('🔍 Fetching content for key: $contentKey');
    fetchContent(contentKey);
  }

  // নতুন মেথড: arguments ছাড়াই direct key দিয়ে content লোড করার জন্য
  // TokenExchangeScreen এটা ব্যবহার করবে → কোনো error snackbar আসবে না
  void loadContentByKey(String key) {
    if (key.isEmpty) {
      content.value = 'Invalid content key.';
      return;
    }
    title.value = 'Content';
    content.value = ''; // reset previous content
    fetchContent(key);
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
          content.value = 'No content available.';
        } else if (data is String) {
          content.value = data;
        } else if (data is num) {
          content.value = data.toString();
        } else if (data is Map<String, dynamic>) {
          final price = data['perTokenPrice'];
          content.value = price?.toString() ?? 'No price information';
        } else {
          content.value = data.toString();
        }
      } else {
        // API error হলে snackbar দেখাবে, কিন্তু build phase-এ না
        showError(response.errorMessage);
        content.value = 'Failed to load content.';
      }
    } catch (e) {
      debugPrint('Content Error: $e');
      showError('Something went wrong');
      content.value = 'Error loading content.';
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    // TokenExchangeScreen-এ permanent রাখতে চাইলে এটা কমেন্ট আউট করো
    // Get.delete<ContentController>();
    super.onClose();
  }
}