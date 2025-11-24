// // ignore_for_file: avoid_print
// import 'package:get/get.dart';
// import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
// import 'package:windx1999/app/services/network_caller/network_caller.dart';
// import 'package:windx1999/app/services/network_caller/network_response.dart';
// import 'package:windx1999/app/urls.dart';
// import 'package:windx1999/get_storage.dart';

// class DeleteChatdataController extends GetxController {
//   final OtpVerifyController otpVerifyController = OtpVerifyController();
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   String? _otpToken;
//   String? get otpToken => _otpToken;

//   Future<bool> deleteChataData({ required String chatId}) async {
//     bool isSuccess = false;

//     _inProgress = true;

//     update();

//     final NetworkResponse response = await Get.find<NetworkCaller>()
//         .deleteRequest(Urls.deleteChatDataById(chatId),
//             accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

//     if (response.isSuccess) {
//       _errorMessage = null;
//       isSuccess = true;
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return isSuccess;
//   }
// }
