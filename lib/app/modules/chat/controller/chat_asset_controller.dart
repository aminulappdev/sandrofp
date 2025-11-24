// import 'package:alyse_roe/app/get_storage.dart';
// import 'package:alyse_roe/app/modules/chat/model/message_model.dart';
// import 'package:alyse_roe/app/services/network_caller/network_caller.dart';
// import 'package:alyse_roe/app/services/network_caller/network_response.dart';
// import 'package:alyse_roe/app/urls.dart';
// import 'package:get/get.dart';

// class ChatAssetsController extends GetxController {
//   bool _inProgress = false; 
//   bool get inProgress => _inProgress;
 
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   ChatMessageModel? allChatModel;
//   MessageData? get assetData => allChatModel?.data;

//   Future<void> geChatAsset({required String chatId}) async {
//     _inProgress = true;

//     update();

//     String token = await StorageUtil.getData(StorageUtil.userAccessToken);

//     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//       Urls.messagesById(chatId),
//       accessToken: token,
//     );

//     if (response.isSuccess) {
//       print('Seen All Data');
//       allChatModel = ChatMessageModel.fromJson(response.responseData);
//       print(
//         '📦 Messages loaded from API: ${allChatModel?.data?.messages.length}',

//       );

//       _inProgress = false;
//     } else {
//       _errorMessage = response.errorMessage;
//       print('❌ Failed to load messages: $_errorMessage');
//       Get.snackbar('Error', 'Failed to load messages: $_errorMessage');
//     }

//     update();
//   }
// }
