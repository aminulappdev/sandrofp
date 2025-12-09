class AllFriendsModel {
    AllFriendsModel({
         this.success,
         this.message,
         this.data,
    });

    final bool? success;
    final String? message;
    final List<AllFriendsItemModel>? data;

    factory AllFriendsModel.fromJson(Map<String, dynamic> json){ 
        return AllFriendsModel( 
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? [] : List<AllFriendsItemModel>.from(json["data"]!.map((x) => AllFriendsItemModel.fromJson(x))),
        );
    }

}

class AllFriendsItemModel {
    AllFriendsItemModel({
        required this.chat,
        required this.message,
        required this.unreadMessageCount,
    });

    final Chat? chat;
    final Message? message;
    final int? unreadMessageCount;

    factory AllFriendsItemModel.fromJson(Map<String, dynamic> json){ 
        return AllFriendsItemModel(
            chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
            message: json["message"] == null ? null : Message.fromJson(json["message"]),
            unreadMessageCount: json["unreadMessageCount"],
        );
    }

}

class Chat {
    Chat({
        required this.id,
        required this.participants,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final List<Participant> participants;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Chat.fromJson(Map<String, dynamic> json){ 
        return Chat(
            id: json["_id"],
            participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
            status: json["status"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Participant {
    Participant({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.profile,
        required this.role,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? phoneNumber;
    final dynamic profile;
    final String? role;

    factory Participant.fromJson(Map<String, dynamic> json){ 
        return Participant(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            profile: json["profile"],
            role: json["role"],
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
        required this.v,
        required this.updatedAt,
    });

    final String? id;
    final String? text;
    final dynamic exchanges;
    final List<dynamic> imageUrl;
    final bool? seen;
    final String? sender;
    final String? receiver;
    final String? chat;
    final DateTime? createdAt;
    final int? v;
    final DateTime? updatedAt;

    factory Message.fromJson(Map<String, dynamic> json){ 
        return Message(
            id: json["_id"],
            text: json["text"],
            exchanges: json["exchanges"],
            imageUrl: json["imageUrl"] == null ? [] : List<dynamic>.from(json["imageUrl"]!.map((x) => x)),
            seen: json["seen"],
            sender: json["sender"],
            receiver: json["receiver"],
            chat: json["chat"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}
