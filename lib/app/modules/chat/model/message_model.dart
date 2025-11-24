class ChatMessageModel {
    ChatMessageModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final MessageData? data;

    factory ChatMessageModel.fromJson(Map<String, dynamic> json){ 
        return ChatMessageModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : MessageData.fromJson(json["data"]),
        );
    }

}

class MessageData {
    MessageData({
        required this.data,
        required this.meta,
    });

    final List<Message> data;
    final Meta? meta;

    factory MessageData.fromJson(Map<String, dynamic> json){ 
        return MessageData(
            data: json["data"] == null ? [] : List<Message>.from(json["data"]!.map((x) => Message.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class Message {
    Message({
        required this.id,
        required this.text,
        required this.exchanges,
        required this.imageUrl,
        required this.seen,
        required this.sender,
        required this.receiver,
        required this.chat,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? text;
    final Exchanges? exchanges;
    final List<dynamic> imageUrl;
    final bool? seen;
    final Receiver? sender;
    final Receiver? receiver;
    final String? chat;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Message.fromJson(Map<String, dynamic> json){ 
        return Message(
            id: json["_id"],
            text: json["text"],
            exchanges: json["exchanges"] == null ? null : Exchanges.fromJson(json["exchanges"]),
            imageUrl: json["imageUrl"] == null ? [] : List<dynamic>.from(json["imageUrl"]!.map((x) => x)),
            seen: json["seen"],
            sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
            receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
            chat: json["chat"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class Exchanges {
    Exchanges({
        required this.id,
        required this.user,
        required this.requestTo,
        required this.status,
        required this.products,
        required this.exchangeWith,
        required this.extraToken,
        required this.totalToken,
        required this.reviewers,
        required this.reason,
        required this.isReviewed,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? user;
    final String? requestTo;
    final String? status;
    final List<String> products;
    final List<String> exchangeWith;
    final dynamic extraToken;
    final dynamic totalToken;
    final List<String> reviewers;
    final String? reason;
    final bool? isReviewed;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Exchanges.fromJson(Map<String, dynamic> json){ 
        return Exchanges(
            id: json["_id"],
            user: json["user"],
            requestTo: json["requestTo"],
            status: json["status"],
            products: json["products"] == null ? [] : List<String>.from(json["products"]!.map((x) => x)),
            exchangeWith: json["exchangeWith"] == null ? [] : List<String>.from(json["exchangeWith"]!.map((x) => x)),
            extraToken: json["extraToken"],
            totalToken: json["totalToken"],
            reviewers: json["reviewers"] == null ? [] : List<String>.from(json["reviewers"]!.map((x) => x)),
            reason: json["reason"],
            isReviewed: json["isReviewed"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Receiver {
    Receiver({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.role,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? phoneNumber;
    final String? role;

    factory Receiver.fromJson(Map<String, dynamic> json){ 
        return Receiver(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            role: json["role"],
        );
    }

}

class Meta {
    Meta({
        required this.page,
        required this.limit,
        required this.total,
        required this.totalPage,
    });

    final int? page;
    final int? limit;
    final int? total;
    final int? totalPage;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPage: json["totalPage"],
        );
    }

}
