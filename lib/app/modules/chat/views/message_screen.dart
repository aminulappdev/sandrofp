// app/modules/chat/views/chat_screen.dart
// FULLY FIXED – NO MORE List<dynamic> ERROR
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/controller/image_decode_controller.dart';
import 'package:sandrofp/app/modules/chat/controller/message_controller.dart';
import 'package:sandrofp/app/modules/chat/widgets/chatting_header.dart';
import 'package:sandrofp/app/modules/chat/widgets/message_input_field.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/socket/socket_service.dart';

class ChatScreen extends StatefulWidget {
  final String? receiverId;
  final String? receiverName;
  final String? receiverImageUrl;
  const ChatScreen({
    super.key,
    this.receiverId,
    this.receiverName,
    this.receiverImageUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController messageCtrl = Get.put(MessageController());
  final SocketService socketService = Get.find<SocketService>();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImageDecodeController imageDecodeController = Get.put(
    ImageDecodeController(),
  );

  late final String userAuthId;
  // final String recieverId = '6918182fa7f19a573dad8d91';
  String recieverId = '';

  @override
  void initState() {
    super.initState();
    userAuthId = StorageUtil.getData(StorageUtil.userId) ?? "";
    recieverId = widget.receiverId ?? '';

    messageCtrl.getMessages(chatId: recieverId).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    });

    socketService.sokect.on('new_message', _handleIncomingMessage);
    socketService.sokect.emit('joinChat', {'chatId': recieverId});
  }

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // এই ফাংশনটা সবচেয়ে গুরুত্বপূর্ণ – List হলে প্রথমটা নেবে
  String _safeImageUrl(dynamic file) {
    if (file == null || file.toString() == 'null') return "";
    if (file is String) return file.trim();
    if (file is List && file.isNotEmpty) return file.first.toString().trim();
    return "";
  }

  void _handleIncomingMessage(dynamic data) {
    print('✅✅ new message arrived: $data');
    try {
      Map<String, dynamic> msg = {};

      if (data is Map && data['message'] != null) {
        final m = data['message'] as Map<String, dynamic>;

        final String imageUrl = _safeImageUrl(m['file'] ?? m['imageUrl']);

        msg = {
          "id":
              m['_id'] ??
              m['id'] ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          "text": m['text']?.toString() ?? "",
          "imageUrl": imageUrl,
          "seen": m['seen'] ?? false,
          "senderId": m['sender'].toString(),
          "senderName": m['senderName']?.toString() ?? "",
          "receiverId": m['receiver'].toString(),
          "chat": m['chat'].toString(),
          "createdAt": (m['createdAt'] ?? DateTime.now()).toString(),
        };
      } else if (data is Map &&
          (data['text'] != null ||
              data['file'] != null ||
              data['imageUrl'] != null)) {
        final String imageUrl = _safeImageUrl(data['file'] ?? data['imageUrl']);

        msg = {
          "id": data['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
          "text": data['text']?.toString() ?? "",
          "imageUrl": imageUrl,
          "senderId":
              data['sender']?.toString() ?? data['senderId']?.toString() ?? "",
          "createdAt":
              data['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        };
      } else {
        return;
      }

      // ডুপ্লিকেট চেক
      if (socketService.messageList.any((e) => e['id'] == msg['id'])) return;

      socketService.messageList.add(msg);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      setState(() {});
    } catch (e) {
      print("Socket parse error: $e");
      print("Raw data: $data");
    }
  }

  bool _isMe(Map<String, dynamic> msg) => msg['senderId'] == userAuthId;

  String _formatTime(String? iso) {
    if (iso == null) return "";
    try {
      return DateFormat('h:mm a').format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return "";
    }
  }

  void _handleFocusChange(bool hasFocus) {
    // if (hasFocus) {
    //   socketService.sokect.emit('typing', {
    //     'chatId': chatId,
    //     'userId': userAuthId,
    //   });
    // } else {
    //   socketService.sokect.emit('stopTyping', {
    //     'chatId': chatId,
    //     'userId': userAuthId,
    //   });
    // }
  }

  Future<void> sendMessageBTN(
    String chatId,
    String text,
    String receiverId,
  ) async {
    print('Send message button pressed');
    print('text: $text');
    if (text.trim().isEmpty && imageDecodeController.imageUrl.isEmpty) {
      Get.snackbar('Error', 'Message or image cannot be empty');
      return;
    }

    socketService.sokect.emit('send_message', {
      "chat": messageCtrl.messageResponse.value.data!.data.first.chat,
      "receiver": receiverId,
      "text": text.trim(),
      "imageUrl": [imageDecodeController.imageUrl],
    });

    messageController.clear();
    imageDecodeController.imageUrl = '';

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  void dispose() {
    socketService.sokect.off('new_message');
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: ChatHeader(
          id: widget.receiverId,
          name: widget.receiverName,
          image: widget.receiverImageUrl,
          isOnline: true,
        ),
      ),
      body: Column(
        children: [
          heightBox12,
          Expanded(
            child: Obx(() {
              final messages = socketService.messageList
                  .toList()
                  .reversed
                  .toList();

              if (messageCtrl.isLoading.value && messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (messages.isEmpty) {
                return Center(
                  child: Text(
                    "No messages yet. Say hello!",
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                );
              }

              return ListView.builder(
                reverse: true,
                controller: scrollController,
                padding: EdgeInsets.all(12.r),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMe = _isMe(msg);
                  final String imageUrl = _safeImageUrl(msg['imageUrl']);

                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 0.75.sw),
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isMe
                            ? const Color(0xff295F40)
                            : const Color(0xffF3F3F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                          bottomLeft: isMe
                              ? Radius.circular(16.r)
                              : Radius.circular(0),
                          bottomRight: isMe
                              ? Radius.circular(0)
                              : Radius.circular(16.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          // Image
                          if (imageUrl.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  imageUrl,
                                  height: 160.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 160.h,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                          if (messageCtrl.messageList[index].exchanges !=
                              null) ...{
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 80.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Yes',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10.w),
                                Container(
                                  width: 80.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          },

                          // Text
                          if (msg['text']?.toString().isNotEmpty == true)
                            messageCtrl.messageList[index].exchanges == null
                                ? Text(
                                    msg['text'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5.sp,
                                      color: isMe
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  )
                                : Text(
                                    '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5.sp,
                                      color: isMe
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _formatTime(msg['createdAt']),
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  color: isMe ? Colors.white70 : Colors.black54,
                                ),
                              ),
                              if (isMe) ...[
                                SizedBox(width: 4.w),
                                Icon(
                                  msg['seen'] == true
                                      ? Icons.done_all
                                      : Icons.done,
                                  size: 16.sp,
                                  color: msg['seen'] == true
                                      ? Colors.cyan
                                      : Colors.white70,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          MessageInputWidget(
            controller: messageController,
            isSending: false,
            chatId: recieverId,
            receiverId: '6918182fa7f19a573dad8d91',
            onSendMessage: sendMessageBTN,
            onFocusChange: _handleFocusChange,
            imageUrl: imageDecodeController.imageUrl,
          ),
        ],
      ),
    );
  }
}
