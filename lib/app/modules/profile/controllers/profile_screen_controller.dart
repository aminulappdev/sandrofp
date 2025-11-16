// app/modules/profile/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/modules/profile/views/edit_profile_screen.dart';

class ProfileScreenController extends GetxController {
  // Profile Data
  final RxMap<String, dynamic> user = {
    'name': 'Sandro Fernando',
    'rating': 4.5,
    'reviews': 100,
    'level': 'Beginner',
    'location': 'New York',
    'age': 25,
    'gender': 'Male',
    'height': "5' 8\"",
    'bio':
        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form...',
  }.obs;

  // Categories & Products
  final RxList<String> categories = [
    'Clothing',
    'Electronics',
    'Furniture',
  ].obs;
  final RxList<RxMap<String, dynamic>> clothingItems =
      <RxMap<String, dynamic>>[].obs;
  final RxList<RxMap<String, dynamic>> electronicItems =
      <RxMap<String, dynamic>>[].obs;

  // Feedback
  final RxList<FeedbackItem> feedbacks = <FeedbackItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();

    
  }

  void loadDummyData() {
    clothingItems.assignAll(List.generate(5, (_) => {'title': 'T-Shirt'}.obs));
    electronicItems.assignAll(List.generate(3, (_) => {'title': 'Phone'}.obs));

    feedbacks.assignAll([
      FeedbackItem(name: 'Alex', rating: 5, comment: 'Great trader!'),
      FeedbackItem(name: 'Rina', rating: 4, comment: 'Fast exchange'),
    ]);
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
