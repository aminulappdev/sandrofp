// import 'package:alyse_roe/app/get_storage.dart';
// import 'package:alyse_roe/app/modules/authentication/views/sign_in_screen.dart';
// import 'package:alyse_roe/app/services/network_caller/network_caller.dart';
// import 'package:alyse_roe/app/services/network_caller/network_response.dart';
// import 'package:alyse_roe/app/urls.dart';
// import 'package:get/get.dart';

// class MessageSeenController extends GetxController {
//   final RxBool _inProgress = false.obs;
//   bool get inProgress => _inProgress.value;

//   final RxString _errorMessage = ''.obs;
//   String get errorMessage => _errorMessage.value;

//   Future<bool> messageSeenById(String id) async {
//     _inProgress.value = true;

//     try {
//       final NetworkResponse response = await Get.find<NetworkCaller>()
//           .patchRequest(
//             Urls.messagesSeenById(id),
//             accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
//           );

//       if (response.isSuccess && response.responseData != null) {
//         _errorMessage.value = '';

//         print('Messege seen Response data : ${response.responseData}');

//         _inProgress.value = false;
//         return true;
//       } else {
//         _errorMessage.value = response.errorMessage;
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
