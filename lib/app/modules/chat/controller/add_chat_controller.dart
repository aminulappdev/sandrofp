
// import 'package:get/get.dart';

// class AddChatControllerController extends GetxController {
//   final RxBool _inProgress = false.obs;
//   bool get inProgress => _inProgress.value;

//   final RxString _errorMessage = ''.obs;
//   String get errorMessage => _errorMessage.value;

//   final RxString _chatId = ''.obs;
//   String get chatId => _chatId.value;

//   final Rx<ChatCreateResponseModel?> chatCreateResponseModel =
//       Rx<ChatCreateResponseModel?>(null);
//   ChatResponseData? get chatResponsedData =>
//       chatCreateResponseModel.value?.data;

//   Future<bool> createChat({String? assetId}) async {
//     _inProgress.value = true;

//     try {
//       Map<String, dynamic> body = {"asset": assetId};

//       final NetworkResponse response = await Get.find<NetworkCaller>()
//           .postRequest(
//             Urls.createChatUrl,
//             body: body,
//             accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
//           );

//       if (response.isSuccess && response.responseData != null) {
//         _errorMessage.value = '';

//         // Parse the response into ChatCreateResponseModel
//         chatCreateResponseModel.value = ChatCreateResponseModel.fromJson(
//           response.responseData,
//         );

//         // Update _chatId with the _id from the response data
//         _chatId.value = chatCreateResponseModel.value?.data?.id ?? '';
//         // Debug print to verify chatId is set
//         print('Updated chatId from controller : ${_chatId.value}');

//         _inProgress.value = false;
//         return true;
//       } else {
//        _errorMessage.value = response.errorMessage;
//         _errorMessage.value.contains('expired') ? Get.to(SignInScreen()) : null;
//         _inProgress.value = false;
//         return false;
//       }
//     } catch (e) {
//       _errorMessage.value = 'Failed to fetch district data: ${e.toString()}';
//       print('Error fetching district data: $e');
//       _inProgress.value = false;
//       return false;
//     }
//   }
// }
