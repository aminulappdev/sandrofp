class ChatCreateResponseModel {
    ChatCreateResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ChatResponseData? data;

    factory ChatCreateResponseModel.fromJson(Map<String, dynamic> json){ 
        return ChatCreateResponseModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ChatResponseData.fromJson(json["data"]),
        );
    }

}

class ChatResponseData {
    ChatResponseData({
        required this.id,
        required this.asset,
        required this.participants,
        required this.lastMessage,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? asset;
    final List<Participant> participants;
    final dynamic lastMessage;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ChatResponseData.fromJson(Map<String, dynamic> json){ 
        return ChatResponseData(
            id: json["_id"],
            asset: json["asset"],
            participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
            lastMessage: json["lastMessage"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Participant {
    Participant({
        required this.id,
        required this.user,
        required this.role,
    });

    final String? id;
    final User? user;
    final String? role;

    factory Participant.fromJson(Map<String, dynamic> json){ 
        return Participant(
            id: json["_id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            role: json["role"],
        );
    }

}

class User {
    User({
        required this.id,
        required this.name,
        required this.image,
    });

    final String? id;
    final String? name;
    final String? image;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["_id"],
            name: json["name"],
            image: json["image"],
        );
    }

}
