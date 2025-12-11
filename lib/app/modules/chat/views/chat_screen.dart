// ChatListScreen.dart (ফ্রন্টএন্ড সার্চ সহ – UI একদম আগের মতো)

// lib/app/modules/chat/views/chat_list_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/socket/socket_service.dart';
import 'package:sandrofp/app/urls.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final SocketService socketService = Get.find<SocketService>();
  final TextEditingController _searchController = TextEditingController();

  // আমাদের একটাই লিস্ট — API + Socket দুই জায়গা থেকে আপডেট হবে
  final RxList<Map<String, dynamic>> chatList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredList =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;

  final String myId = StorageUtil.getData(StorageUtil.userId) ?? '';

  @override 
  void initState() {
    super.initState();
    _loadChatsFromApi();
    // _setupSocketListeners();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    // Socket listener অফ করি (মেমরি লিক প্রিভেন্ট)
    socketService.sokect.off('chat_list');
    socketService.sokect.off('messageSeen');
    super.dispose();
  }

  // প্রথমবার API থেকে চ্যাট লিস্ট লোড
  Future<void> _loadChatsFromApi() async {
    isLoading.value = true;
    final token = await StorageUtil.getData(StorageUtil.userAccessToken);

    final response = await NetworkCaller().getRequest(
      Urls.allFriendsChatnUrl,
      accessToken: token,
    );

    if (response.isSuccess && response.responseData != null) {
      final List<dynamic> data =
          response.responseData['data'] ?? response.responseData;
      _populateChatListFromApi(data);
    } else {
      Get.snackbar("Error", "Failed to load chats");
    }
    isLoading.value = false;
  }

  // API ডাটা থেকে chatList পূরণ করা
  void _populateChatListFromApi(List<dynamic> apiData) {
    chatList.clear();

    for (var item in apiData) {
      final chat = item['chat'];
      final participants = chat['participants'] as List<dynamic>;
      if (participants.isEmpty) continue;

      final receiver = participants[0];
      final receiverId = receiver['_id']?.toString() ?? '';
      if (receiverId.isEmpty) continue;

      // প্রোফাইল ইমেজ
      String profileImage = '';
      final p = receiver['profile'];
      if (p is String && p.isNotEmpty) {
        profileImage = p;
      } else if (p is Map<String, dynamic> && p['url'] != null) {
        profileImage = p['url'];
      }

      // লাস্ট মেসেজ
      final msg = item['message'];
      final text = (msg?['text'] ?? '').toString().trim();
      final images = msg?['imageUrl'] is List ? msg['imageUrl'] : [];
      final displayMsg = text.isNotEmpty
          ? text
          : (images.isNotEmpty ? "Photo" : "Start chatting");

      final isFromMe = (msg?['sender']?.toString() ?? '') == myId;

      chatList.add({
        "chatId": chat['_id'] ?? '',
        "receiverId": receiverId,
        "name": receiver['name'] ?? 'Unknown',
        "profileImage": profileImage,
        "lastMessage": displayMsg,
        "lastMessageTime":
            msg?['createdAt'] ?? DateTime.now().toIso8601String(),
        "unreadMessageCount": isFromMe ? 0 : (item['unreadMessageCount'] ?? 0),
        "isSeen": msg?['seen'] ?? true,
      });
    }

    _sortByTime();
    filteredList.assignAll(chatList);
  }

  // Socket থেকে নতুন মেসেজ এলে
  // void _setupSocketListeners() {
  //   socketService.sokect.on('chat_list', (rawData) {
  //     print('Chat list data from socket: $rawData');
  //     final data = rawData is String ? jsonDecode(rawData) : rawData;
  //     final message = data['message'] ?? data;

  //     final senderId = message['sender']?.toString() ?? '';
  //     final receiverId = message['receiver']?.toString() ?? '';
  //     final chatId = message['chat']?.toString() ?? '';

  //     final isFromMe = senderId == myId;
  //     final friendId = isFromMe ? receiverId : senderId;
  //     if (friendId.isEmpty) return;

  //     final text = (message['text'] ?? '').toString().trim();
  //     final images = message['imageUrl'] is List ? message['imageUrl'] : [];
  //     final displayMsg = text.isNotEmpty
  //         ? text
  //         : (images.isNotEmpty ? "Photo" : "Message");

  //     final index = chatList.indexWhere((e) => e['receiverId'] == friendId);

  //     if (index != -1) {
  //       // আগে থেকে আছে → আপডেট করে সামনে আনো
  //       final item = chatList[index];
  //       item['lastMessage'] = displayMsg;
  //       item['lastMessageTime'] =
  //           message['createdAt'] ?? DateTime.now().toIso8601String();
  //       if (!isFromMe) {
  //         item['unreadMessageCount'] = (item['unreadMessageCount'] ?? 0) + 1;
  //       }
  //       item['isSeen'] = isFromMe;

  //       chatList.removeAt(index);
  //       chatList.insert(0, item);
  //     } else {
  //       // নতুন চ্যাট
  //       chatList.insert(0, {
  //         "chatId": chatId,
  //         "receiverId": friendId,
  //         "name": message['senderName'] ?? 'Someone',
  //         "profileImage": message['senderImage'] ?? '',
  //         "lastMessage": displayMsg,
  //         "lastMessageTime":
  //             message['createdAt'] ?? DateTime.now().toIso8601String(),
  //         "unreadMessageCount": isFromMe ? 0 : 1,
  //         "isSeen": isFromMe,
  //       });
  //     }

  //     _sortByTime();
  //     _applySearchFilter();
  //   });
  // }

  void _sortByTime() {
    chatList.sort((a, b) {
      final timeA =
          DateTime.tryParse(a['lastMessageTime'] ?? '') ?? DateTime(1970);
      final timeB =
          DateTime.tryParse(b['lastMessageTime'] ?? '') ?? DateTime(1970);
      return timeB.compareTo(timeA);
    });
  }

  void _onSearchChanged() {
    _applySearchFilter();
  }

  void _applySearchFilter() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredList.assignAll(chatList);
    } else {
      filteredList.assignAll(
        chatList
            .where(
              (e) =>
                  (e['name']?.toString().toLowerCase() ?? '').contains(query),
            )
            .toList(),
      );
    }
  }

  String _getRelativeTime(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      return DateFormatter(DateTime.parse(isoString)).getRelativeTimeFormat();
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search chats...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: Obx(() {
              if (isLoading.value && chatList.isEmpty) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 40,
                  ),
                );
              }

              if (filteredList.isEmpty) {
                return Center(
                  child: Text(
                    _searchController.text.isEmpty
                        ? "No chats yet"
                        : "No chat found",
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
                  final unread = friend['unreadMessageCount'] as int? ?? 0;

                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        radius: 28.r,
                        backgroundColor: Colors.blue.shade50,
                        child: CircleAvatar(
                          radius: 26.r,
                          backgroundImage:
                              friend['profileImage'].toString().isNotEmpty
                              ? NetworkImage(friend['profileImage'])
                              : AssetImage(Assets.images.profile.path)
                                    as ImageProvider,
                        ),
                      ),
                      title: Text(
                        friend['name'] ?? 'Unknown',
                        style: GoogleFonts.poppins(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        friend['lastMessage'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: unread > 0 ? Colors.black : Colors.grey[600],
                          fontWeight: unread > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _getRelativeTime(friend['lastMessageTime']),
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (unread > 0) ...[
                            const SizedBox(height: 4),
                            CircleAvatar(
                              radius: 10.r,
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
                        ],
                      ),
                      onTap: () {
                        Get.to(
                          () => ChatScreen(
                            receiverId: friend['receiverId'],
                            receiverName: friend['name'],
                            receiverImageUrl: friend['profileImage'],
                          ),
                        )!.then((_) {
                          // চ্যাট থেকে ফিরে এলে unread 0 করতে চাইলে এখানে API/socket emit করতে পারো
                        });
                      },
                    ),
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
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sandrofp/app/modules/chat/controller/all_friend_controller.dart';
// import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
// import 'package:sandrofp/app/modules/chat/widgets/chat_list_widget.dart';
// import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';
// import 'package:sandrofp/app/res/custom_style/custom_size.dart';
// import 'package:sandrofp/app/services/socket/socket_service.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:sandrofp/gen/assets.gen.dart';

// class ChatListScreen extends StatefulWidget {
//   const ChatListScreen({super.key});

//   @override
//   State<ChatListScreen> createState() => _ChatListScreenState();
// }

// class _ChatListScreenState extends State<ChatListScreen> {
//   final SocketService socketService = Get.find<SocketService>();
//   final FriendController friendController = Get.put(FriendController());

//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _filteredList = [];

//   @override
//   void initState() {
//     super.initState();

//     if (friendController.friendList.isEmpty) {
//       friendController.getAllFriends();
//     }

//     socketService.sokect.on('updatedChats', (data) {
//       friendController.getAllFriends();
//     });

//     _searchController.addListener(_performSearch);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_performSearch);
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _performSearch() {
//     final query = _searchController.text.trim().toLowerCase();
//     final originalList = socketService.socketFriendList;

//     if (query.isEmpty) {
//       _filteredList = originalList;
//     } else {
//       _filteredList = originalList.where((friend) {
//         final name = (friend['name']?.toString() ?? '').toLowerCase();
//         return name.contains(query);
//       }).toList();
//     }

//     setState(() {}); // UI রিফ্রেশ
//   }

//   String _getTime(String? iso) {
//     if (iso == null || iso.isEmpty) return '';
//     try {
//       return DateFormatter(DateTime.parse(iso)).getRelativeTimeFormat();
//     } catch (e) {
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ChatListHeader(searchController: _searchController),
//               heightBox10,

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Obx(() {
//                       if (friendController.inProgress.value) {
//                         return SizedBox(
//                           height: 500.h,
//                           child: Center(
//                             child: LoadingAnimationWidget.staggeredDotsWave(
//                               color: Colors.black,
//                               size: 26,
//                             ),
//                           ),
//                         );
//                       }

//                       final displayList = _searchController.text.isEmpty
//                           ? socketService.socketFriendList
//                           : _filteredList;

//                       if (displayList.isEmpty) {
//                         return SizedBox(
//                           height: 400.h,
//                           child: Center(
//                             child: Text(
//                               _searchController.text.isEmpty
//                                   ? "No chats yet"
//                                   : "No chat found",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 16.sp,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         );
//                       }

//                       return ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemCount: displayList.length,
//                         itemBuilder: (context, index) {
//                           final friend = displayList[index];

//                           final name = friend['name']?.toString() ?? 'Unknown';
//                           final profileImage =
//                               friend['profileImage']?.toString() ?? '';
//                           final lastMessage =
//                               friend['lastMessage']?.toString() ?? 'No message';
//                           final time = friend['lastMessageTime']?.toString();
//                           final unread = friend['unreadMessageCount'] is int
//                               ? friend['unreadMessageCount']
//                               : int.tryParse(
//                                       friend['unreadMessageCount']
//                                               ?.toString() ??
//                                           '0',
//                                     ) ??
//                                     0;
//                           final receiverId =
//                               friend['receiverId']?.toString() ?? '';

//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                             child: InkWell(
//                               onTap: () {
//                                 Get.to(
//                                   () => ChatScreen(
//                                     receiverId: receiverId,
//                                     receiverName: name,
//                                     receiverImageUrl: profileImage,
//                                   ),
//                                 );
//                               },
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       // Profile Picture
//                                       CircleAvatar(
//                                         backgroundColor: Colors.blue,
//                                         radius: 24.r,
//                                         child: CircleAvatar(
//                                           radius: 22.r,
//                                           backgroundColor: Colors.white,
//                                           child: CircleAvatar(
//                                             radius: 20.r,
//                                             backgroundImage:
//                                                 profileImage.isNotEmpty
//                                                 ? NetworkImage(profileImage)
//                                                 : AssetImage(
//                                                         Assets
//                                                             .images
//                                                             .profile
//                                                             .path,
//                                                       )
//                                                       as ImageProvider,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),

//                                       // Right Side
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 SizedBox(
//                                                   width: 220.w,
//                                                   child: Text(
//                                                     name,
//                                                     style: GoogleFonts.poppins(
//                                                       fontSize: 20.sp,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   _getTime(time),
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 12.sp,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 SizedBox(
//                                                   width: 220.w,
//                                                   child: Text(
//                                                     lastMessage,
//                                                     style: GoogleFonts.poppins(
//                                                       fontSize: 14.sp,
//                                                       fontWeight: unread > 0
//                                                           ? FontWeight.w600
//                                                           : FontWeight.w400,
//                                                       color: unread > 0
//                                                           ? Colors.black
//                                                           : Colors.grey[600],
//                                                     ),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     maxLines: 2,
//                                                   ),
//                                                 ),
//                                                 if (unread > 0)
//                                                   CircleAvatar(
//                                                     radius: 8.r,
//                                                     backgroundColor:
//                                                         Colors.blue,
//                                                     child: Text(
//                                                       unread > 99
//                                                           ? '99+'
//                                                           : unread.toString(),
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                             fontSize: 10.sp,
//                                                             color: Colors.white,
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                           ),
//                                                     ),
//                                                   ),
//                                               ],
//                                             ),
//                                             heightBox12,
//                                             Container(
//                                               height: 1,
//                                               width: 250,
//                                               color: Colors.grey,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
