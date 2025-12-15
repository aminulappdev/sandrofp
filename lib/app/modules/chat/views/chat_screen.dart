// lib/app/modules/chat/views/chat_list_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/controller/all_friend_controller.dart';
import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';
import 'package:sandrofp/app/services/socket/socket_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sandrofp/gen/assets.gen.dart';
 
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final SocketService socketService = Get.find<SocketService>();
  final FriendController friendController = Get.find<FriendController>();

  final TextEditingController _searchController = TextEditingController();
  String search = '';

  final String myId = StorageUtil.getData(StorageUtil.userId) ?? '';

  @override
  void initState() {
    super.initState();

    if (socketService.socketFriendList.isEmpty) {
      friendController.getAllFriends();
    }

    _searchController.addListener(() {
      setState(() {
        search = _searchController.text;
      });
    });

    socketService.sokect.on('new_message', (data) {
      _handleIncomingMessage(data);
    });

    socketService.sokect.on('chat_list', (data) {
      _handleIncomingMessage(data);
    });
  }

  void _handleIncomingMessage(dynamic rawData) {
    if (rawData == null) return;

    Map<String, dynamic> messageData = rawData is String
        ? Map<String, dynamic>.from(jsonDecode(rawData))
        : Map<String, dynamic>.from(rawData is Map ? rawData : {});

    if (messageData.containsKey('message')) {
      messageData = messageData['message'];
    }

    final String chatId = messageData['chat']?.toString() ?? '';
    final String senderId = messageData['sender']?.toString() ?? '';
    final String receiverId = messageData['receiver']?.toString() ?? '';
    final String text = (messageData['text'] ?? '').toString().trim();
    final List images = messageData['imageUrl'] ?? [];
    final String displayMsg =
        text.isNotEmpty ? text : (images.isNotEmpty ? "Photo" : "Message");
    final String time =
        messageData['createdAt']?.toString() ?? DateTime.now().toIso8601String();

    final bool isFromMe = senderId == myId;
    final String friendId = isFromMe ? receiverId : senderId;
    if (friendId.isEmpty) return;

    String friendName =
        messageData['senderName']?.toString() ??
        messageData['receiverName']?.toString() ??
        'Unknown';
    String profileImage = messageData['senderImage']?.toString() ?? '';

    final list = socketService.socketFriendList;
    int index =
        list.indexWhere((e) => e['id'] == chatId || e['receiverId'] == friendId);

    if (index != -1) {
      final item = Map<String, dynamic>.from(list[index]);
      item['lastMessage'] = displayMsg;
      item['lastMessageTime'] = time;

      if (!isFromMe) {
        item['unreadMessageCount'] = (item['unreadMessageCount'] ?? 0) + 1;
      }

      list.removeAt(index);
      list.insert(0, item);
    } else {
      list.insert(0, {
        "id": chatId,
        "receiverId": friendId,
        "name": friendName,
        "profileImage": profileImage,
        "lastMessage": displayMsg,
        "lastMessageTime": time,
        "unreadMessageCount": isFromMe ? 0 : 1,
      });
    }

    list.sort((a, b) {
      final timeA =
          DateTime.tryParse(a['lastMessageTime'] ?? '') ?? DateTime(1970);
      final timeB =
          DateTime.tryParse(b['lastMessageTime'] ?? '') ?? DateTime(1970);
      return timeB.compareTo(timeA);
    });

    list.refresh();
  }

  @override
  void dispose() {
    _searchController.dispose();
    socketService.sokect.off('new_message');
    socketService.sokect.off('chat_list');
    super.dispose();
  }

  String _getRelativeTime(String? iso) {
    if (iso == null || iso.isEmpty) return 'Just now';
    try {
      return DateFormatter(DateTime.parse(iso)).getRelativeTimeFormat();
    } catch (e) {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chats', leading: Container(), isBack: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search chats...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final list = socketService.socketFriendList;

              if (friendController.inProgress.value && list.isEmpty) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 24,
                  ),
                );
              }

              final filteredList = list.where((e) {
                final name = e['name']?.toString().toLowerCase() ?? '';
                return search.isEmpty ||
                    name.contains(search.toLowerCase());
              }).toList();

              if (filteredList.isEmpty) {
                return Center(
                  child: Text(
                    search.isEmpty ? "No chats yet" : "No chat found",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final friend = filteredList[index];
                  final unread = (friend['unreadMessageCount'] ?? 0) as int;

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          friend['profileImage'].toString().isNotEmpty
                              ? NetworkImage(friend['profileImage'])
                              : AssetImage(
                                  Assets.images.profile.path,
                                ) as ImageProvider,
                    ),
                    title: Text(friend['name'] ?? ''),
                    subtitle: Text(
                      friend['lastMessage'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_getRelativeTime(friend['lastMessageTime'])),
                        if (unread > 0)
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            child: Text(
                              unread > 99 ? '99+' : '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Get.to(
                        () => ChatScreen(
                          receiverId: friend['receiverId'],
                          receiverName: friend['name'],
                          receiverImageUrl: friend['profileImage'],
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
