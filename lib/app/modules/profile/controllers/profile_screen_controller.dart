// app/modules/profile/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_feedback_controller.dart';

import 'package:sandrofp/app/modules/profile/views/edit_profile_screen.dart';

class ProfileScreenController extends GetxController {
  final MyFeedbackController myFeedbackController = Get.put(
    MyFeedbackController(), 
  );


  // Feedback
  final RxList<FeedbackItem> feedbacks = <FeedbackItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    myFeedbackController.getMyFeedback();
  }

  void goToEditProfile() => Get.to(EditProfileScreen());
}

class FeedbackItem {
  final String name;
  final int rating;
  final String comment;
  FeedbackItem({
    required this.name,
    required this.rating,
    required this.comment,
  });
}
