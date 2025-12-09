// lib/app/modules/chat/controller/all_friend_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/model/all_friend_model.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/socket/socket_service.dart';
import 'package:sandrofp/app/urls.dart';

class FriendController extends GetxController {
  final SocketService socketService = Get.find<SocketService>();

  var inProgress = false.obs;
  var friendList = <AllFriendsItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllFriends();
  }

  Future<void> getAllFriends() async {
    if (inProgress.value) return;
    inProgress.value = true;

    final token = await StorageUtil.getData(StorageUtil.userAccessToken);

    final response = await NetworkCaller().getRequest(
      Urls.allFriendsChatnUrl,
      accessToken: token,
    );

    if (response.isSuccess && response.responseData != null) {
      final model = AllFriendsModel.fromJson(response.responseData);
      friendList.assignAll(model.data ?? []);

      socketService.socketFriendList.clear();

      for (var item in friendList) {
        final chat = item.chat!;
        if (chat.participants.isEmpty) continue;
        final receiver = chat.participants[0];

        String profileImage = '';
        final p = receiver.profile;
        if (p is String && p.isNotEmpty) profileImage = p;
        if (p is Map<String, dynamic> && p['url'] != null)
          profileImage = p['url'];

        final msg = item.message;
        final text = msg?.text?.trim() ?? '';
        final images = msg?.imageUrl ?? [];
        final displayMsg = text.isNotEmpty
            ? text
            : (images.isNotEmpty ? "Photo" : "No message");

        socketService.socketFriendList.add({
          "id": chat.id ?? '',
          "receiverId": receiver.id ?? '',
          "name": receiver.name ?? 'Unknown',
          "profileImage": profileImage,
          "lastMessage": displayMsg,
          "lastMessageTime": msg?.createdAt?.toIso8601String() ?? '',
          "isSeen": msg?.seen ?? true,
          "unreadMessageCount": item.unreadMessageCount ?? 0,
        });
      }
      socketService.socketFriendList.refresh();
    }
    inProgress.value = false;
  }
}


// import 'package:get/get.dart';
// import 'package:sandrofp/app/get_storage.dart';
// import 'package:sandrofp/app/modules/chat/model/all_friend_model.dart';
// import 'package:sandrofp/app/services/network_caller/network_caller.dart';
// import 'package:sandrofp/app/services/network_caller/network_response.dart';
// import 'package:sandrofp/app/services/socket/socket_service.dart';
// import 'package:sandrofp/app/urls.dart';

// class FriendController extends GetxController {
//   final SocketService socketService = Get.put(SocketService());

//   // Reactive variables
//   var inProgress = false.obs;
//   var friends = AllFriendsModel().obs;
//   var friendList = <AllFriendsItemModel>[].obs;
//   var isLoading = false.obs;
//   String? errorMessage;

//   @override
//   void onInit() {
//     super.onInit();
//     getAllFriends();
//   }

//   Future<bool> getAllFriends() async {
//     inProgress.value = true;
//     isLoading.value = true;

//     final String currentUserId = await StorageUtil.getData(StorageUtil.userId) ?? '';

//     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//       Urls.allFriendsChatnUrl,
//       accessToken: await StorageUtil.getData(StorageUtil.userAccessToken),
//     );

//     print('All Friends Response: ${response.responseData}');

//     if (response.isSuccess && response.responseData != null) {
//       friends.value = AllFriendsModel.fromJson(response.responseData);
//       friendList.assignAll(friends.value.data ?? []);
//       socketService.socketFriendList.clear();

//       for (final friend in friendList) {
//         final chat = friend.chat!;
//         final message = friend.message;

//         // participants থেকে current user বাদ দিয়ে অন্যজনকে নিচ্ছি
//         final Participant receiver = chat.participants.firstWhere(
//           (p) => p.id != currentUserId,
//           // যদি কোনো কারণে না পাওয়া যায় (যদিও হওয়ার কথা না)
//           orElse: () => chat.participants.first,
//         );

//         // last message এর sender আমি কি না চেক করা
//         final bool isLastMessageByMe = message?.sender == currentUserId;

//         // Profile image handling (profile null হলে empty string)
//         final String profileImage = receiver.profile is String
//             ? (receiver.profile?.isNotEmpty == true ? receiver.profile! : '')
//             : (receiver.profile is Map && receiver.profile["url"] != null)
//                 ? receiver.profile["url"]
//                 : '';

//         socketService.socketFriendList.add({
//           "id": chat.id ?? '',
//           "receiverId": receiver.id ?? '',
//           "name": receiver.name ?? 'Unknown User',
//           "profileImage": profileImage,
//           "lastMessage": message?.text?.trim().isNotEmpty == true
//               ? message!.text!
//               : (message?.imageUrl?.isNotEmpty == true ? "Photo" : "No message"),
//           "lastMessageSender": message?.sender ?? '',
//           "lastMessageTime": message?.createdAt?.toIso8601String() ?? '',
//           "isSeen": message?.seen ?? true,
//           "unreadMessageCount": friend.unreadMessageCount ?? 0,
//           // Asset related fields empty রাখলাম কারণ এই API তে নেই
//           "assetDescription": '',
//           "assetQnty": '',
//           "assetName": '',
//           "assetImage": message?.imageUrl?.isNotEmpty == true
//               ? message!.imageUrl!.first.toString()
//               : '',
//         });
//       }

//       errorMessage = null;
//       inProgress.value = false;
//       isLoading.value = false;
//       return true;
//     } else {
//       errorMessage = response.errorMessage ?? "Failed to load friends";
//       inProgress.value = false;
//       isLoading.value = false;
//       return false;
//     }
//   }
// }