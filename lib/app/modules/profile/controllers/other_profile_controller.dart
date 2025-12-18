// app/modules/other_profile/controllers/other_profile_controller.dart
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_feedback_controller.dart';
import 'package:sandrofp/app/modules/profile/model/profile_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class OtherProfileController extends GetxController {
  final RxBool obscureText = true.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<ProfileModel?> _profileModel = Rx<ProfileModel?>(null);
  ProfileData? get profileData => _profileModel.value?.data;

  late final MyFeedbackController myFeedbackController;

  final RxBool isLoading = false.obs;
  late String id;

  var userId;
  var userNName;
  var userImage;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    id = args?['id']?.toString() ?? '';

    if (id.isEmpty) {
      showError("User ID not found");
      Get.back();
      return;
    }

    myFeedbackController = Get.put(MyFeedbackController());

    myFeedbackController.sellerId = id;
    myFeedbackController.getMyFeedback();

    getOtherProfile();
  }

  Future<void> getOtherProfile() async {
    isLoading(true);
    try {
      final response = await _networkCaller.getRequest(
        Urls.otherProfile(id),
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData['data'] != null) {
        _profileModel.value = ProfileModel.fromJson(response.responseData);
        print('PROFILE DATA: ${_profileModel.value?.data}');
        userId = _profileModel.value?.data?.id ?? '';
        userNName = _profileModel.value?.data?.name ?? '';
        userImage = _profileModel.value?.data?.profile ?? '';
      } else {
        //K showError(response.errorMessage);
      }
    } catch (e) {
      showError("Failed to load profile");
    } finally {
      isLoading(false);
    }
  }

  // আপনার পুরোনো সব Rx ভ্যারিয়েবল ঠিক আগের মতোই আছে
  var userName = ''.obs;
  var rating = 0.0.obs;
  var reviewCount = 0.obs;
  var level = 'Beginner'.obs;
  var location = 'New York'.obs;
  var age = '25'.obs;
  var gender = 'Male'.obs;
  var height = "5' 8\"".obs;
  var bio =
      '''
There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humor, or randomized words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum.
  '''
          .obs;

  var exchangeCategories = ['Other', 'Fashion', 'Accessories'].obs;
  var clothingItems1 = List.generate(5, (_) => true).obs;
  var clothingItems2 = List.generate(5, (_) => true).obs;

  void goToChat() {
    print('USER ID: $userId');
    Get.to(
      ChatScreen(
        receiverId: userId,
        receiverName: userNName,
        receiverImageUrl: userImage,
      ),
    );
  }
}
