// ChatListScreen.dart (ফ্রন্টএন্ড সার্চ সহ – UI একদম আগের মতো)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/chat/controller/all_friend_controller.dart';
import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
import 'package:sandrofp/app/modules/chat/widgets/chat_list_widget.dart';
import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
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
  final FriendController friendController = Get.put(FriendController());

  // সার্চ কন্ট্রোলার ও ফিল্টার করা লিস্ট
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredList = [];

  @override
  void initState() {
    super.initState();

    if (friendController.friendList.isEmpty) {
      friendController.getAllFriends();
    }

    // রিয়েল-টাইম আপডেট
    socketService.sokect.on('updatedChats', (data) {
      friendController.getAllFriends(); // পরে অপটিমাইজ করা যাবে
    });

    // সার্চ টেক্সট চেঞ্জ হলে ফিল্টার করা
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim().toLowerCase();
    final originalList = socketService.socketFriendList;

    if (query.isEmpty) {
      _filteredList = originalList;
    } else {
      _filteredList = originalList.where((friend) {
        final name = (friend['name']?.toString() ?? '').toLowerCase();
        return name.contains(query);
      }).toList();
    }

    setState(() {}); // UI রিফ্রেশ
  }

  String _getTime(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    try {
      return DateFormatter(DateTime.parse(iso)).getRelativeTimeFormat();
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatListHeader(searchController: _searchController), // পাস করলাম
              heightBox10,

              // Chat List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (friendController.inProgress.value) {
                        return SizedBox(
                          height: 500.h,
                          child: Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.black,
                              size: 26,
                            ),
                          ),
                        );
                      }

                      // যদি সার্চ না থাকে তাহলে অরিজিনাল লিস্ট, থাকলে ফিল্টার করা লিস্ট
                      final displayList = _searchController.text.isEmpty
                          ? socketService.socketFriendList
                          : _filteredList;

                      if (displayList.isEmpty) {
                        return SizedBox(
                          height: 400.h,
                          child: Center(
                            child: Text(
                              _searchController.text.isEmpty
                                  ? "No chats yet"
                                  : "No chat found",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: displayList.length,
                        itemBuilder: (context, index) {
                          final friend = displayList[index];

                          final name = friend['name']?.toString() ?? 'Unknown';
                          final profileImage =
                              friend['profileImage']?.toString() ?? '';
                          final lastMessage =
                              friend['lastMessage']?.toString() ?? 'No message';
                          final time = friend['lastMessageTime']?.toString();
                          final unread = friend['unreadMessageCount'] is int
                              ? friend['unreadMessageCount']
                              : int.tryParse(
                                      friend['unreadMessageCount']
                                              ?.toString() ??
                                          '0',
                                    ) ??
                                    0;
                          final receiverId =
                              friend['receiverId']?.toString() ?? '';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => ChatScreen(
                                    receiverId: receiverId,
                                    receiverName: name,
                                    receiverImageUrl: profileImage,
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Profile Picture
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 24.r,
                                        child: CircleAvatar(
                                          radius: 22.r,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20.r,
                                            backgroundImage:
                                                profileImage.isNotEmpty
                                                ? NetworkImage(profileImage)
                                                : AssetImage(
                                                        Assets
                                                            .images
                                                            .profile
                                                            .path,
                                                      )
                                                      as ImageProvider,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Right Side
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 220.w,
                                                  child: Text(
                                                    name,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  _getTime(time),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 220.w,
                                                  child: Text(
                                                    lastMessage,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.sp,
                                                      fontWeight: unread > 0
                                                          ? FontWeight.w600
                                                          : FontWeight.w400,
                                                      color: unread > 0
                                                          ? Colors.black
                                                          : Colors.grey[600],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                if (unread > 0)
                                                  CircleAvatar(
                                                    radius: 8.r,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    child: Text(
                                                      unread > 99
                                                          ? '99+'
                                                          : unread.toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 10.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            heightBox12,
                                            Container(
                                              height: 1,
                                              width: 250,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
