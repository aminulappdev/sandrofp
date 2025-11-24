// import 'package:dirve_society/app/modules/chat/model/chat_id_model.dart';
// import 'package:dirve_society/get_storage.dart';
// import 'package:dirve_society/services/network_caller/network_caller.dart';
// import 'package:dirve_society/services/network_caller/network_response.dart';
// import 'package:dirve_society/urls.dart';
// import 'package:get/get.dart';

// class GetChatIdController extends GetxController {
//   final NetworkCaller networkCaller = Get.put(NetworkCaller());

//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   ChatIdModel? _chatIdModel;
//   List<ChatIdItemModel>? get chatData => _chatIdModel?.data;

//   String? _chatId;
//   String? get chatId => _chatId;

//   final int _limit = 200;
//   int page = 0;

//   Future<bool> getChat(String userId) async {
//     if (_inProgress) {
//       return false;
//     }

//     bool isSuccess = false;

//     _inProgress = true;
//     update();

//     Map<String, dynamic> queryParams = {'limit': _limit, 'page': page};
//     final NetworkResponse response = await networkCaller.getRequest(
//       Urls.getChatIdUrlById(userId),
//       queryParams: queryParams,
//       accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
//     );

//     if (response.isSuccess) {
//       _errorMessage = null;
//       isSuccess = true;

//       _chatIdModel = ChatIdModel.fromJson(response.responseData);

//       _chatId = response.responseData['data'][0]['_id'];

//       _errorMessage = null;
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return isSuccess;
//   }
// }
