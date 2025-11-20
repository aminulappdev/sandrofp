// feedback_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/common/views/feedback_completed.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class FeedbackController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();
  final RxBool isLoading = false.obs;

  late String sellerId;
  late String exchangeId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    sellerId = args?['sellerId'] as String? ?? '';
    exchangeId = args?['exchangeId'] as String? ?? '';

    print('SELLER ID: $sellerId');
    print('EXCHANGE ID: $exchangeId');
  }

  // Rating
  var communicationRating = 0.obs;

  // Single selected tag (null means nothing selected)
  var selectedTag = Rxn<String>(); // Rx<String?> এর শর্টকাট

  // Feedback text
  var feedbackText = ''.obs;

  final List<String> quickTags = [
    'Good',
    'Excellent',
    'Fast',
    'Helpful',
    'Professional',
    'Friendly',
    'Slow',
    'Rude',
    'Confusing',
    'Unprofessional',
  ];

  // Single tag selection
  void selectTag(String tag) {
    if (selectedTag.value == tag) {
      selectedTag.value = null; // Deselect if tapped again
    } else {
      selectedTag.value = tag; // Select only this one
    }
  }

  void setCommunicationRating(int rating) {
    communicationRating.value = rating;
  }

  void submitFeedback() async {
    if (communicationRating.value == 0) {
      showError('Please give a rating');
      return;
    }

    if (selectedTag.value == null) {
      showError('Please select one feedback tag');
      return;
    }

    await showLoadingOverLay(
      asyncFunction: _performSubmit,
      msg: 'Submitting...',
    );
  }

  Future<void> _performSubmit() async {
    isLoading(true);
    try {
      final body = {
        "title": selectedTag.value!,
        "seller": sellerId,
        "review": feedbackText.value.trim(),
        "rating": communicationRating.value,
        "reference": exchangeId,
      };

      final response = await _networkCaller.postRequest(
        Urls.feedbackUrl,
        body: body,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess) {
        Get.offAll(() => const FeedbackCompletedScreen());
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      debugPrint('Feedback Error: $e');
      showError('Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}
