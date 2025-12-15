// // lib/app/modules/chat/views/chat_screen.dart
// // FINAL + CHAT LIST UPDATE INCLUDED
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:sandrofp/app/get_storage.dart';
// import 'package:sandrofp/app/modules/chat/controller/change_exchange_status_con.dart';
// import 'package:sandrofp/app/modules/chat/controller/image_decode_controller.dart';
// import 'package:sandrofp/app/modules/chat/controller/message_controller.dart';
// import 'package:sandrofp/app/modules/chat/widgets/chatting_header.dart';
// import 'package:sandrofp/app/modules/chat/widgets/message_input_field.dart';
// import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
// import 'package:sandrofp/app/res/custom_style/custom_size.dart';
// import 'package:sandrofp/app/services/network_caller/custom.dart';
// import 'package:sandrofp/app/services/socket/socket_service.dart';

// class ChatScreen extends StatefulWidget {
//   final String? receiverId;
//   final String? receiverName;
//   final String? receiverImageUrl;
//   const ChatScreen({
//     super.key,
//     this.receiverId,
//     this.receiverName,
//     this.receiverImageUrl,
//   });

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final ChangeExchangeStatusController changeExchangeStatusController = Get.put(
//     ChangeExchangeStatusController(),
//   );
//   final MessageController messageCtrl = Get.put(MessageController());
//   final SocketService socketService =
//       Get.find<SocketService>(); // Get.find দিয়ে নাও
//   final TextEditingController textCtrl = TextEditingController();
//   final ScrollController scrollController = ScrollController();
//   final ImageDecodeController imageDecodeController = Get.put(
//     ImageDecodeController(),
//   );

//   late final String userAuthId;
//   late final String chatId;

//   @override
//   void initState() {
//     super.initState();
//     userAuthId = StorageUtil.getData(StorageUtil.userId) ?? "";
//     chatId = widget.receiverId ?? '';

//     messageCtrl.getMessages(chatId: chatId).then((_) => _scrollToBottom());

//     // নতুন মেসেজ এলে দুটো জায়গায় আপডেট
//     socketService.sokect.on('new_message', _handleIncomingMessage);

//     // চ্যাট লিস্ট আপডেটের জন্যও শুনছি (যদিও আমরা নিজেই আপডেট করব)
//     socketService.sokect.on('chat_list', (data) {
//       print('chat_list updated from server');
//     });

//     socketService.sokect.emit('joinChat', {'chatId': chatId});
//   }

//   void _scrollToBottom() {
//     if (!scrollController.hasClients) return;
//     scrollController.animateTo(
//       0,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   String _safeImageUrl(dynamic file) {
//     if (file == null || file.toString() == 'null') return "";
//     if (file is String) return file.trim();
//     if (file is List && file.isNotEmpty) return file.first.toString().trim();
//     return "";
//   }

//   // এটাই মূল জাদু – নতুন মেসেজ এলে চ্যাট লিস্টও আপডেট করবে
//   void _handleIncomingMessage(dynamic data) {
//     try {
//       Map<String, dynamic> msg = {};

//       if (data is Map && data['message'] != null) {
//         final m = data['message'] as Map<String, dynamic>;
//         final String imageUrl = _safeImageUrl(m['file'] ?? m['imageUrl']);

//         msg = {
//           "id": m['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
//           "text": m['text']?.toString() ?? "",
//           "imageUrl": imageUrl,
//           "seen": m['seen'] ?? false,
//           "senderId": m['sender'].toString(),
//           "createdAt": (m['createdAt'] ?? DateTime.now()).toString(),
//         };
//       } else if (data is Map) {
//         final String imageUrl = _safeImageUrl(data['file'] ?? data['imageUrl']);
//         msg = {
//           "id": data['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
//           "text": data['text']?.toString() ?? "",
//           "imageUrl": imageUrl,
//           "seen": data['seen'] ?? false,
//           "senderId": data['sender']?.toString() ?? "",
//           "createdAt":
//               data['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
//         };
//       } else {
//         return;
//       }

//       // ডুপ্লিকেট চেক
//       if (socketService.messageList.any((e) => e['id'] == msg['id'])) return;

//       // ১. Message list এ যোগ
//       socketService.messageList.add(msg);

//       // ২. চ্যাট লিস্টে আপডেট করো (এটাই মূল কাজ)
//       final friendIndex = socketService.socketFriendList.indexWhere(
//         (e) => e['id'] == chatId,
//       );

//       final String displayText = msg['text'].toString().isNotEmpty
//           ? msg['text'].toString()
//           : (msg['imageUrl'].toString().isNotEmpty ? "Photo" : "No message");

//       if (friendIndex != -1) {
//         // আগে থেকে থাকলে আপডেট + উপরে আনো
//         final updated = {
//           ...socketService.socketFriendList[friendIndex],
//           "lastMessage": displayText,
//           "lastMessageTime": msg['createdAt'],
//           "isSeen": msg['seen'] ?? false,
//           "unreadMessageCount": msg['senderId'] == userAuthId
//               ? socketService
//                     .socketFriendList[friendIndex]['unreadMessageCount']
//               : (socketService
//                             .socketFriendList[friendIndex]['unreadMessageCount'] ??
//                         0) +
//                     1,
//         };

//         socketService.socketFriendList.removeAt(friendIndex);
//         socketService.socketFriendList.insert(0, updated);
//       } else {
//         // নতুন চ্যাট হলে যোগ করো (যদিও সাধারণত হবে না)
//         socketService.socketFriendList.insert(0, {
//           "id": chatId,
//           "receiverId": widget.receiverId,
//           "name": widget.receiverName ?? 'Unknown',
//           "profileImage": widget.receiverImageUrl ?? '',
//           "lastMessage": displayText,
//           "lastMessageTime": msg['createdAt'],
//           "isSeen": false,
//           "unreadMessageCount": msg['senderId'] == userAuthId ? 0 : 1,
//         });
//       }

//       if (mounted) setState(() {});
//       WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
//     } catch (e) {
//       print("Socket parse error in ChatScreen: $e");
//     }
//   }

//   bool _isMe(Map<String, dynamic> msg) => msg['senderId'] == userAuthId;

//   String _formatTime(String? iso) {
//     if (iso == null) return "";
//     try {
//       return DateFormat('h:mm a').format(DateTime.parse(iso).toLocal());
//     } catch (_) {
//       return "";
//     }
//   }

//   // বাকি ফাংশনগুলো ঠিক আছে – কোনো চেঞ্জ লাগেনি
//   dynamic _findExchangeByMessageId(String messageId) {
//     if (messageCtrl.messageResponse.value.data?.data == null) return null;
//     try {
//       return messageCtrl.messageResponse.value.data!.data
//           .firstWhere((m) => m.id == messageId || m.id.toString() == messageId)
//           .exchanges;
//     } catch (_) {
//       return null;
//     }
//   }

//   dynamic _findExchangeRequestToByMessageId(String messageId) {
//     final ex = _findExchangeByMessageId(messageId);
//     return ex?.requestTo;
//   }

//   dynamic _findExchangeStatusByMessageId(String messageId) {
//     final ex = _findExchangeByMessageId(messageId);
//     return ex?.status;
//   }

//   Future<void> sendMessageBTN(
//     String chatId,
//     String text,
//     String receiverId,
//   ) async {
//     if (text.trim().isEmpty && imageDecodeController.imageUrl.isEmpty) {
//       Get.snackbar('Error', 'Message or image cannot be empty');
//       return;
//     }

//     socketService.sokect.emit('send_message', {
//       "receiver": receiverId,
//       "text": text.trim(),
//       "imageUrl": imageDecodeController.imageUrl.isNotEmpty
//           ? [imageDecodeController.imageUrl]
//           : [],
//     });

//     textCtrl.clear();
//     imageDecodeController.imageUrl = '';
//   }

//   void changeStatus(String status, String exchangeId) {
//     showLoadingOverLay(
//       asyncFunction: () async {
//         final success = await changeExchangeStatusController.changeStatus(
//           status: status,
//           exchangeId: exchangeId,
//         );
//         if (success) {
//           await messageCtrl.getMessages(chatId: chatId);
//           showSuccess('Status changed');
//         } else {
//           showError('Failed');
//         }
//       },
//       msg: 'Please wait...',
//     );
//   }

//   @override
//   void dispose() {
//     socketService.sokect.off('new_message', _handleIncomingMessage);

//     textCtrl.dispose();
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(80.h),
//         child: ChatHeader(
//           id: widget.receiverId,
//           name: widget.receiverName,
//           image: widget.receiverImageUrl,
//           isOnline: true,
//         ),
//       ),
//       body: Column(
//         children: [
//           heightBox12,
//           Expanded(
//             child: Obx(() {
//               final messages = socketService.messageList.reversed.toList();

//               if (messages.isEmpty && messageCtrl.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (messages.isEmpty) {
//                 return Center(
//                   child: Text(
//                     "No messages yet. Say hello!",
//                     style: GoogleFonts.poppins(fontSize: 16.sp),
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 reverse: true,
//                 controller: scrollController,
//                 padding: EdgeInsets.all(12.r),
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   final msg = messages[index];
//                   final isMe = _isMe(msg);
//                   final String imageUrl = _safeImageUrl(msg['imageUrl']);
//                   final String messageId = msg['id'].toString();

//                   final exchangeData = _findExchangeByMessageId(messageId);
//                   final exchangeTo = _findExchangeRequestToByMessageId(
//                     messageId,
//                   );
//                   final exchangeStatus = _findExchangeStatusByMessageId(
//                     messageId,
//                   );

//                   return Align(
//                     alignment: isMe
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft,
//                     child: Container(
//                       constraints: BoxConstraints(maxWidth: 0.75.sw),
//                       margin: EdgeInsets.symmetric(vertical: 6.h),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16.w,
//                         vertical: 12.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: isMe
//                             ? const Color(0xff295F40)
//                             : const Color(0xffF3F3F5),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(16.r),
//                           topRight: Radius.circular(16.r),
//                           bottomLeft: isMe
//                               ? Radius.circular(16.r)
//                               : Radius.circular(0),
//                           bottomRight: isMe
//                               ? Radius.circular(0)
//                               : Radius.circular(16.r),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: isMe
//                             ? CrossAxisAlignment.end
//                             : CrossAxisAlignment.start,
//                         children: [
//                           if (imageUrl.isNotEmpty)
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 6.h),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12.r),
//                                 child: Image.network(
//                                   imageUrl,
//                                   height: 160.h,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),

//                           if (exchangeData != null) ...[
//                             Container(
//                               width: 300.w,
//                               height: 200.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.r),
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                     (exchangeData.exchangeWith as List)
//                                             .isNotEmpty
//                                         ? exchangeData
//                                                   .exchangeWith
//                                                   .first
//                                                   .images
//                                                   .first
//                                                   .url ??
//                                               ''
//                                         : '',
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             heightBox10,
//                             // বাকি এক্সচেঞ্জ UI তোমার আগের মতোই
//                             // (আমি শর্ট করে দিলাম, তুমি তোমারটা রাখো)
//                           ],

//                           if (msg['text']?.toString().isNotEmpty == true &&
//                               exchangeData == null)
//                             Text(
//                               msg['text'],
//                               style: GoogleFonts.poppins(
//                                 color: isMe ? Colors.white : Colors.black87,
//                                 fontSize: 15.5.sp,
//                               ),
//                             ),

//                           SizedBox(height: 4.h),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 _formatTime(msg['createdAt']),
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 11.sp,
//                                   color: isMe ? Colors.white70 : Colors.black54,
//                                 ),
//                               ),
//                               if (isMe) ...[
//                                 SizedBox(width: 4.w),
//                                 Icon(
//                                   msg['seen'] == true
//                                       ? Icons.done_all
//                                       : Icons.done,
//                                   size: 16.sp,
//                                   color: msg['seen'] == true
//                                       ? Colors.cyan
//                                       : Colors.white70,
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),

//           MessageInputWidget(
//             controller: textCtrl,
//             isSending: false,
//             chatId: widget.receiverId ?? '',
//             receiverId: widget.receiverId ?? '',
//             onSendMessage: sendMessageBTN,
//             imageUrl: imageDecodeController.imageUrl,
//           ),
//         ],
//       ),
//     );
//   }
// }









// // lib/app/services/socket/socket_service.dart
// import 'package:get/get.dart';
// import 'package:sandrofp/app/get_storage.dart';
// import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
// import 'package:sandrofp/app/urls.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService extends GetxController {
//   late IO.Socket _socket;

//   RxBool isLoading = false.obs;
//   final ProfileController profileDetailsController = Get.put(
//     ProfileController(),
//   );

//   final _messageList = <Map<String, dynamic>>[].obs;
//   final _socketFriendList = <Map<String, dynamic>>[].obs;
//   final _notificationsList = <Map<String, dynamic>>[].obs;

//   RxList<Map<String, dynamic>> get messageList => _messageList;
//   RxList<Map<String, dynamic>> get socketFriendList => _socketFriendList;
//   RxList<Map<String, dynamic>> get notificationsList => _notificationsList;

//   IO.Socket get sokect => _socket;

//   // এই মেথডটা যোগ করলাম → যাতে বাইরে থেকে ক্লিয়ার করা যায়
//   void clearMessageList() {
//     _messageList.clear();
//   }
//   Future<SocketService> init() async {
//     print('Init socket service. Connecting...');
//     final token = await StorageUtil.getData(StorageUtil.userAccessToken);
//     final userId = await StorageUtil.getData(StorageUtil.userId);
//     print('token: $token');
//     print('userId: $userId');

//     _socket = IO.io(Urls.socketUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       'extraHeaders': {'token': '$token'},
//     });

//     _socket.on('connect', (_) {
//       print('Connected to the server');
//       _socket.emit("connection", userId);
//     });

//     _socket.onConnect((_) async {
//       print('Socket connected');
//       _socket.emit("connection", userId);

//       // এই লাইনটা যোগ করো – real-time chat list চালু করার জন্য
//       _startRealTimeChatList();
//     });

//     _socket.on('checking_notification', (data) {
//       print('Check in data from socket');
//       print(data);
//     });

//     _socket.onDisconnect((_) {
//       print('Socket disconnected');
//     });

//     return this;
//   }

//   void disconnect() {
//     _socket.disconnect();
//   }

//   // এই পুরো মেথডটা নিচে যোগ করো (যেকোনো জায়গায়, disconnect() এর আগে/পরে)
//   void _startRealTimeChatList() {
//     _socket.off('chat_list'); // duplicate prevent

//     _socket.on('chat_list', (data) async {
//       print('chat_list event → $data');
//       final currentUserId = await StorageUtil.getData(StorageUtil.userId) ?? '';

//       void process(Map<String, dynamic> json) {
//         try {
//           final chat = json['chat'] as Map<String, dynamic>?;
//           final msg = json['message'] as Map<String, dynamic>?;
//           final unread = json['unreadMessageCount'] as int? ?? 0;

//           if (chat == null) return;
//           final parts = (chat['participants'] as List<dynamic>? ?? []);
//           if (parts.isEmpty) return;

//           final receiver = parts[0] as Map<String, dynamic>;

//           // Profile image (null/string/map সব handle)
//           String profileImage = '';
//           final p = receiver['profile'];
//           if (p != null) {
//             if (p is String && p.isNotEmpty) {
//               profileImage = p;
//             } else if (p is Map<String, dynamic> && p['url'] != null) {
//               profileImage = p['url'];
//             }
//           }

//           final text = (msg?['text'] as String?)?.trim() ?? '';
//           final images = (msg?['imageUrl'] as List<dynamic>?) ?? [];
//           final displayMsg = text.isNotEmpty
//               ? text
//               : (images.isNotEmpty ? "Photo" : "No message");

//           final item = {
//             "id": chat['_id']?.toString() ?? '',
//             "receiverId": receiver['_id']?.toString() ?? '',
//             "name": receiver['name']?.toString() ?? 'Unknown',
//             "profileImage": profileImage,
//             "lastMessage": displayMsg,
//             "lastMessageSender": msg?['sender']?.toString() ?? '',
//             "lastMessageTime": msg?['createdAt']?.toString() ?? '',
//             "isSeen": msg?['seen'] ?? true,
//             "unreadMessageCount": unread,
//             "assetImage": images.isNotEmpty ? images.first.toString() : '',
//           };

//           final i = _socketFriendList.indexWhere((e) => e['id'] == item['id']);
//           if (i != -1) _socketFriendList.removeAt(i);
//           _socketFriendList.insert(0, item);
//         } catch (e) {
//           print('Parse error in chat_list: $e');
//         }
//       }

//       if (data is List) {
//         _socketFriendList.clear();
//         for (var item in data) process(item as Map<String, dynamic>);
//       } else if (data is Map<String, dynamic>) {
//         process(data);
//       }

//       _socketFriendList.refresh();
//     });
//   }
// }




// // app/modules/chat/controller/message_controller.dart
// import 'package:get/get.dart';
// import 'package:sandrofp/app/get_storage.dart';
// import 'package:sandrofp/app/modules/chat/model/message_model.dart';
// import 'package:sandrofp/app/services/network_caller/network_caller.dart';
// import 'package:sandrofp/app/services/network_caller/network_response.dart';
// import 'package:sandrofp/app/services/socket/socket_service.dart';
// import 'package:sandrofp/app/urls.dart';

// class MessageController extends GetxController {
//   var isLoading = false.obs;

//   var messageResponse = ChatMessageModel(
//     success: false,
//     message: "",
//     data: null,
//   ).obs;

//   final SocketService socketService = Get.find<SocketService>();

//   Future<void> getMessages({required String chatId}) async {
//     isLoading(true);

//     // এই ৩ লাইন = ১০০% বাগ ফিক্স
//     socketService.clearMessageList();      // পুরানো চ্যাট মুছে ফেলো
//     socketService.messageList.refresh();   // Obx কে ফোর্স রিফ্রেশ
//     update();                              // যদি কোথাও GetBuilder থাকে

//     try {
//       String token = await StorageUtil.getData(StorageUtil.userAccessToken);

//       final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//         Urls.messagesById(chatId),
//         accessToken: token,
//         queryParams: {"sort": "createdAt", "limit": "9999"},
//       );

//       if (response.isSuccess && response.responseData != null) {
//         messageResponse.value = ChatMessageModel.fromJson(response.responseData);

//         final List<Map<String, dynamic>> newMessages = [];

//         if (messageResponse.value.data?.data != null) {
//           for (final msg in messageResponse.value.data!.data) {
//             final imageUrl = msg.imageUrl is List
//                 ? (msg.imageUrl.isNotEmpty ? msg.imageUrl.first.toString() : "")
//                 : (msg.imageUrl?.toString() ?? "");

//             final mapMsg = {
//               "id": msg.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//               "text": msg.text ?? "",
//               "imageUrl": imageUrl,
//               "seen": msg.seen ?? false,
//               "senderId": msg.sender?.id ?? "",
//               "createdAt": msg.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
//             };

//             // ডুপ্লিকেট এড়ানো
//             if (!newMessages.any((e) => e['id'] == mapMsg['id'])) {
//               newMessages.add(mapMsg);
//             }
//           }
//         }

//         // একসাথে সব যোগ করো → কোনো ফ্লিকার/ফ্ল্যাশ হবে না
//         socketService.messageList.assignAll(newMessages);
//       }
//     } catch (e) {
//       print("Error loading messages: $e");
//       Get.snackbar("Error", "Failed to load messages");
//     } finally {
//       isLoading(false);
//     }
//   }
// }











// // lib/app/modules/chat/controller/all_friend_controller.dart
// import 'package:get/get.dart';
// import 'package:sandrofp/app/get_storage.dart';
// import 'package:sandrofp/app/modules/chat/model/all_friend_model.dart';
// import 'package:sandrofp/app/services/network_caller/network_caller.dart';
// import 'package:sandrofp/app/services/socket/socket_service.dart';
// import 'package:sandrofp/app/urls.dart';

// class FriendController extends GetxController {
//   final SocketService socketService = Get.find<SocketService>();

//   var inProgress = false.obs;
//   var friendList = <AllFriendsItemModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getAllFriends();
//   }

//   Future<void> getAllFriends() async {
//     if (inProgress.value) return;
//     inProgress.value = true;

//     final token = await StorageUtil.getData(StorageUtil.userAccessToken);

//     final response = await NetworkCaller().getRequest(
//       Urls.allFriendsChatnUrl,
//       accessToken: token,
//     );

//     if (response.isSuccess && response.responseData != null) {
//       final model = AllFriendsModel.fromJson(response.responseData);
//       friendList.assignAll(model.data ?? []);

//       socketService.socketFriendList.clear();

//       for (var item in friendList) {
//         final chat = item.chat!;
//         if (chat.participants.isEmpty) continue;
//         final receiver = chat.participants[0];

//         String profileImage = '';
//         final p = receiver.profile;
//         if (p is String && p.isNotEmpty) profileImage = p;
//         if (p is Map<String, dynamic> && p['url'] != null) profileImage = p['url'];

//         final msg = item.message;
//         final text = msg?.text?.trim() ?? '';
//         final images = msg?.imageUrl ?? [];
//         final displayMsg = text.isNotEmpty ? text : (images.isNotEmpty ? "Photo" : "No message");

//         socketService.socketFriendList.add({
//           "id": chat.id ?? '',
//           "receiverId": receiver.id ?? '',
//           "name": receiver.name ?? 'Unknown',
//           "profileImage": profileImage,
//           "lastMessage": displayMsg,
//           "lastMessageTime": msg?.createdAt?.toIso8601String() ?? '',
//           "isSeen": msg?.seen ?? true,
//           "unreadMessageCount": item.unreadMessageCount ?? 0,
//         });
//       }
//       socketService.socketFriendList.refresh();
//     }
//     inProgress.value = false;
//   }
// }


 









// // lib/app/modules/chat/views/chat_list_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sandrofp/app/modules/chat/controller/all_friend_controller.dart';
// import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
// import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';
// import 'package:sandrofp/app/services/socket/socket_service.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

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
//     socketService.init();
//     if (friendController.friendList.isEmpty) {
//       friendController.getAllFriends();
//     }
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
//     final original = socketService.socketFriendList;

//     setState(() {
//       _filteredList = query.isEmpty
//           ? original
//           : original
//                 .where(
//                   (e) => (e['name']?.toString().toLowerCase() ?? '').contains(
//                     query,
//                   ),
//                 )
//                 .toList();
//     });
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
//       body: Column(
//         children: [
//           // তোমার সার হেডার/সার্চবার (যদি থাকে)
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: "Search chats...",
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 contentPadding: const EdgeInsets.symmetric(vertical: 0),
//               ),
//             ),
//           ),

//           // মূল লিস্ট – এখানে Expanded দিয়ে সীমাবদ্ধ করা হয়েছে
//           Expanded(
//             child: Obx(() {
//               if (friendController.inProgress.value) {
//                 return Center(
//                   child: LoadingAnimationWidget.staggeredDotsWave(
//                     color: Colors.black,
//                     size: 40,
//                   ),
//                 );
//               }

//               final displayList = _searchController.text.isEmpty
//                   ? socketService.socketFriendList
//                   : _filteredList;

//               if (displayList.isEmpty) {
//                 return Center(
//                   child: Text(
//                     _searchController.text.isEmpty
//                         ? "No chats yet"
//                         : "No chat found",
//                     style: GoogleFonts.poppins(
//                       fontSize: 18.sp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                 itemCount: displayList.length,
//                 itemBuilder: (context, index) {
//                   final friend = displayList[index];
//                   final unread = friend['unreadMessageCount'] as int? ?? 0;

//                   return Card(
//                     elevation: 0,
//                     color: Colors.white,
//                     margin: const EdgeInsets.symmetric(vertical: 0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 0,
//                       ),
//                       leading: CircleAvatar(
//                         radius: 28.r,
//                         backgroundColor: Colors.blue.shade50,
//                         child: CircleAvatar(
//                           radius: 26.r,
//                           backgroundImage:
//                               friend['profileImage'].toString().isNotEmpty
//                               ? NetworkImage(friend['profileImage'])
//                               : const AssetImage('assets/images/profile.png')
//                                     as ImageProvider,
//                         ),
//                       ),
//                       title: Text(
//                         friend['name'] ?? 'Unknown',
//                         style: GoogleFonts.poppins(
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       subtitle: Text(
//                         friend['lastMessage'] ?? '',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14.sp,
//                           color: unread > 0 ? Colors.black : Colors.grey[600],
//                           fontWeight: unread > 0
//                               ? FontWeight.w600
//                               : FontWeight.normal,
//                         ),
//                       ),
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             _getTime(friend['lastMessageTime']),
//                             style: GoogleFonts.poppins(
//                               fontSize: 12.sp,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           if (unread > 0) ...[
//                             const SizedBox(height: 4),
//                             CircleAvatar(
//                               radius: 10.r,
//                               backgroundColor: Colors.blue,
//                               child: Text(
//                                 unread > 99 ? '99+' : '$unread',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                       onTap: () {
//                         Get.to(
//                           () => ChatScreen(
//                             receiverId: friend['receiverId'],
//                             receiverName: friend['name'],
//                             receiverImageUrl: friend['profileImage'],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
