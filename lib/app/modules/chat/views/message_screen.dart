// app/modules/chat/views/chat_screen.dart
// FINAL VERSION – Exchange শুধু MessageController থেকে, কোনো RangeError নেই
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/controller/change_exchange_status_con.dart';
import 'package:sandrofp/app/modules/chat/controller/image_decode_controller.dart';
import 'package:sandrofp/app/modules/chat/controller/message_controller.dart';
import 'package:sandrofp/app/modules/chat/views/eschange_preview_screen.dart';
import 'package:sandrofp/app/modules/chat/widgets/chatting_header.dart';
import 'package:sandrofp/app/modules/chat/widgets/message_input_field.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
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
  final ChangeExchangeStatusController changeExchangeStatusController = Get.put(
    ChangeExchangeStatusController(),
  );
  final MessageController messageCtrl = Get.put(MessageController());
  final SocketService socketService = Get.put(SocketService());
  final TextEditingController textCtrl = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImageDecodeController imageDecodeController = Get.put(
    ImageDecodeController(),
  );

  late final String userAuthId;
  String recieverId = '';

  @override
  void initState() {
    super.initState();
    userAuthId = StorageUtil.getData(StorageUtil.userId) ?? "";
    recieverId = widget.receiverId ?? '';

    messageCtrl.getMessages(chatId: recieverId).then((_) {
      _scrollToBottom();
    });

    socketService.sokect.on('new_message', _handleIncomingMessage);
  }

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  String _safeImageUrl(dynamic file) {
    if (file == null || file.toString() == 'null') return "";
    if (file is String) return file.trim();
    if (file is List && file.isNotEmpty) return file.first.toString().trim();
    return "";
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      print('Incoming message from socket: $data');

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
          "createdAt": (m['createdAt'] ?? DateTime.now()).toString(),
        };
      } else if (data is Map) {
        final String imageUrl = _safeImageUrl(data['file'] ?? data['imageUrl']);
        msg = {
          "id": data['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
          "text": data['text']?.toString() ?? "",
          "imageUrl": imageUrl,
          "seen": data['seen'] ?? false,
          "senderId":
              data['sender']?.toString() ?? data['senderId']?.toString() ?? "",
          "createdAt":
              data['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        };
      } else {
        return;
      }

      if (socketService.messageList.any((e) => e['id'] == msg['id'])) return;

      socketService.messageList.add(msg);
      if (mounted) setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      print("Socket parse error: $e");
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

  // এটা সবচেয়ে গুরুত্বপূর্ণ ফাংশন – id দিয়ে exchange খুঁজে দেবে
  dynamic _findExchangeByMessageId(String messageId) {
    if (messageCtrl.messageResponse.value.data?.data == null) return null;
    try {
      final found = messageCtrl.messageResponse.value.data!.data.firstWhere(
        (m) => m.id == messageId || m.id.toString() == messageId,
      );
      return found.exchanges;
    } catch (_) {
      return null;
    }
  }

  dynamic _findExchangeId(String messageId) {
    if (messageCtrl.messageResponse.value.data?.data == null) return null;
    try {
      final found = messageCtrl.messageResponse.value.data!.data.firstWhere(
        (m) => m.id == messageId || m.id.toString() == messageId,
      );
      return found.exchanges?.id;
    } catch (_) {
      return null;
    }
  }

  dynamic _findExchangeRequestToByMessageId(String messageId) {
    if (messageCtrl.messageResponse.value.data?.data == null) return null;
    try {
      final found = messageCtrl.messageResponse.value.data!.data.firstWhere(
        (m) => m.id == messageId || m.id.toString() == messageId,
      );
      return found.exchanges?.requestTo;
    } catch (_) {
      return null;
    }
  }

  dynamic _findExchangeStatusByMessageId(String messageId) {
    if (messageCtrl.messageResponse.value.data?.data == null) return null;
    try {
      final found = messageCtrl.messageResponse.value.data!.data.firstWhere(
        (m) => m.id == messageId || m.id.toString() == messageId,
      );
      return found.exchanges?.status;
    } catch (_) { 
      return null;
    }
  }

  Future<void> sendMessageBTN(
    String chatId,
    String text,
    String receiverId,
  ) async {
    print('BUTTON CLICKED');
    print('Chat ID: $chatId');
    print('Text: $text');
    print('Receiver ID: $receiverId');
    if (text.trim().isEmpty && imageDecodeController.imageUrl.isEmpty) {
      Get.snackbar('Error', 'Message or image cannot be empty');
      return;
    }

    socketService.sokect.emit('send_message', {
      "receiver": receiverId,
      "text": text.trim(),
      "imageUrl": imageDecodeController.imageUrl.isNotEmpty
          ? [imageDecodeController.imageUrl]
          : [],
    });

    textCtrl.clear();
    imageDecodeController.imageUrl = '';
  }

  void changeStatus(String status, String exchangeId) {
    showLoadingOverLay(
      asyncFunction: () async => await _performStatusChange(status, exchangeId),
      msg: 'Please wait...',
    );
  }

  Future<void> _performStatusChange(String status, String exchangeId) async {
    final success = await changeExchangeStatusController.changeStatus(
      status: status,
      exchangeId: exchangeId,
    );
    if (success) {
      await messageCtrl.getMessages(chatId: recieverId);
      showSuccess('Status changed successfully');
    } else {
      showError('Failed to change status');
    }
  }

  @override
  void dispose() {
    socketService.sokect.off('new_message', _handleIncomingMessage);
    textCtrl.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
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
              final messages = socketService.messageList.reversed.toList();

              if (messageCtrl.isLoading.value) {
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
                  final String messageId = msg['id'].toString();

                  // এখানে exchanges খুঁজছি id দিয়ে → কখনো RangeError আসবে না
                  final exchangeData = _findExchangeByMessageId(messageId);
                  var exchangeTo = _findExchangeRequestToByMessageId(messageId);
                  var exchangeId = _findExchangeId(messageId);
                  final exchangeStatus = _findExchangeStatusByMessageId(
                    messageId,
                  );
                  // print('EXCHANGE DATA: $exchangeStatus');

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
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 160.h,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Exchange Card (Yes/No buttons)
                          if (exchangeData != null)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Container(
                                  width: 300.w,
                                  height: 200.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        (exchangeData.exchangeWith as List)
                                                .isNotEmpty
                                            ? exchangeData
                                                      .exchangeWith
                                                      .first
                                                      .images
                                                      .first
                                                      .url ??
                                                  ''
                                            : '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:
                                        exchangeTo !=
                                            StorageUtil.getData(
                                              StorageUtil.userId,
                                            )
                                        ? Container()
                                        : IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => EschangePreviewScreen(
                                                  exchangeId: exchangeId ?? '',
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.visibility,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                heightBox10,
                                exchangeStatus == 'accepted'
                                    ? Container(
                                        width: 120.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Accepted',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    : exchangeStatus == 'approved'
                                    ? Container(
                                        width: 120.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Approved',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    : 
                                    exchangeStatus == 'rejected'
                                    ? Container(
                                        width: 120.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Rejected',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    :  exchangeStatus == 'decline'
                                    ? Container(
                                        width: 120.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Declined',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          exchangeTo !=
                                                  StorageUtil.getData(
                                                    StorageUtil.userId,
                                                  )
                                              ? Container( 
                                                  width: 180.w,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.r,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Pending Approval',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14.sp,
                                                          ),
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => changeStatus(
                                                        'accepted',
                                                        exchangeData.id,
                                                      ),
                                                      child: Container(
                                                        width: 120.w,
                                                        height: 40.h,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.r,
                                                              ),
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey
                                                                .shade300,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Yes',
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    GestureDetector(
                                                      onTap: () => changeStatus(
                                                        'decline',
                                                        exchangeData.id,
                                                      ),
                                                      child: Container(
                                                        width: 120.w,
                                                        height: 40.h,
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.r,
                                                              ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'No',
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                              ],
                            ),

                          // Text Message
                          if (msg['text']?.toString().isNotEmpty == true &&
                              exchangeData == null)
                            Text(
                              msg['text'],
                              style: GoogleFonts.poppins(
                                fontSize: 15.5.sp,
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                            ),

                          SizedBox(height: 4.h),

                          // Time + Seen Icon
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
            controller: textCtrl,
            isSending: false,
            chatId: widget.receiverId ?? '',
            receiverId: widget.receiverId ?? '',
            onSendMessage: sendMessageBTN,
            imageUrl: imageDecodeController.imageUrl,
          ),
        ],
      ),
    );
  }
}
