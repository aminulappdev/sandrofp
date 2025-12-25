// app/modules/chat/controller/message_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/model/message_model.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/services/socket/socket_service.dart';
import 'package:sandrofp/app/urls.dart';

class MessageController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage; 

  final SocketService socketService = Get.find<SocketService>();
  var isLoading = false.obs;

  var messageResponse = ChatMessageModel(
    success: false,
    message: "",
    data: null,
  ).obs;
  var messageList = <Message>[].obs;

  Future<void> getMessages({required String chatId}) async {
    _inProgress = true;
    isLoading(true);
    update();

    try {
      String token = await StorageUtil.getData(StorageUtil.userAccessToken);

      final NetworkResponse response = await Get.find<NetworkCaller>()
          .getRequest(
            Urls.messagesById(chatId),
            accessToken: token,
            queryParams: {"sort": "createdAt", "limit": "9999"},
          );

      if (response.isSuccess && response.responseData != null) {
        messageResponse.value = ChatMessageModel.fromJson(
          response.responseData,
        );

        messageList.clear();
        // এই লাইনটা মুছে ফেলা হয়েছে → এটাই সব সমস্যার মূল ছিল
        socketService.messageList.clear();
        if (messageResponse.value.data?.data != null) {
          messageList.addAll(messageResponse.value.data!.data);

          for (final msg in messageResponse.value.data!.data) {
            final mapMsg = {
              "id": msg.id ?? "",
              "text": msg.text ?? "",
              "imageUrl": msg.imageUrl,
              "seen": msg.seen ?? false,
              "senderId": msg.sender?.id ?? "",
              "senderName": msg.sender?.name ?? "",
              "receiverId": msg.receiver?.id ?? "",
              "chat": msg.chat ?? "",
              "createdAt":
                  msg.createdAt?.toIso8601String() ??
                  DateTime.now().toIso8601String(),
            };

            // ডুপ্লিকেট চেক করে যোগ করো
            if (!socketService.messageList.any(
              (e) => e['id'] == mapMsg['id'],
            )) {
              socketService.messageList.add(mapMsg);
            }
          }
        }
      } else {
        _errorMessage = response.errorMessage;
        Get.snackbar("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "Exception: $e";
      Get.snackbar("Error", "Failed to load messages");
      print(e);
    } finally {
      _inProgress = false;
      isLoading(false);
      update();
    }
  }

  void sendAutoTherapistMessage({
    required String chatId,
    required String receiverId,
    required String therapistName,
  }) {
    final key = "autoMessageSent_$chatId";
    if (StorageUtil.getData(key) == true) return; 

    final autoMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: "Hi, I’m $therapistName. How are you feeling today?",
      exchanges: null,
      imageUrl: [],
      seen: false,
      sender: Receiver(
        id: receiverId,
        name: therapistName,
        email: "",
        phoneNumber: "",
        role: "therapist",
      ),
      receiver: null,
      chat: chatId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    messageList.add(autoMessage);

    final mapMsg = {
      "id": autoMessage.id!,
      "text": autoMessage.text!,
      "imageUrl": autoMessage.imageUrl,
      "seen": false,
      "senderId": receiverId,
      "senderName": therapistName,
      "receiverId": "",
      "chat": chatId,
      "createdAt": autoMessage.createdAt!.toIso8601String(),
      "exchanges": null,
    };

    if (!socketService.messageList.any((e) => e['id'] == mapMsg['id'])) {
      socketService.messageList.add(mapMsg);
    }

    StorageUtil.saveData(key, true);
    update();
  }
}
