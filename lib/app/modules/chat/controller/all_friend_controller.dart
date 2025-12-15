
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

      final myId = await StorageUtil.getData(StorageUtil.userId) ?? '';

      for (var item in friendList) {
        final chat = item.chat!;
        if (chat.participants.isEmpty) continue;

        final receiver = chat.participants[0];
        String profileImage = '';
        final p = receiver.profile;
        if (p is String && p.isNotEmpty) profileImage = p;
        if (p is Map<String, dynamic> && p['url'] != null) profileImage = p['url'];

        final msg = item.message;
        final text = msg?.text?.trim() ?? '';
        final images = msg?.imageUrl ?? [];
        final displayMsg = text.isNotEmpty
            ? text
            : (images.isNotEmpty ? "Photo" : "Start chatting");

        final isFromMe = (msg?.sender ?? '') == myId;
        final unreadCount = isFromMe ? 0 : (item.unreadMessageCount ?? 0);

        socketService.socketFriendList.add({
          "id": chat.id ?? '',
          "receiverId": receiver.id ?? '',
          "name": receiver.name ?? 'Unknown',
          "profileImage": profileImage,
          "lastMessage": displayMsg,
          "lastMessageTime": msg?.createdAt?.toIso8601String() ?? '',
          "isSeen": msg?.seen ?? true,
          "unreadMessageCount": unreadCount,
        });
      }

      // Latest message top-এ আনার জন্য সর্ট
      _sortFriendList();
    }

    inProgress.value = false;
  }

  void _sortFriendList() {
    socketService.socketFriendList.sort((a, b) {
      final timeA = DateTime.tryParse(a['lastMessageTime'] ?? '') ?? DateTime(1970);
      final timeB = DateTime.tryParse(b['lastMessageTime'] ?? '') ?? DateTime(1970);
      return timeB.compareTo(timeA); // descending
    });
    socketService.socketFriendList.refresh();
  }

  // যদি manual refresh দরকার হয়
  void refreshList() => getAllFriends();
}