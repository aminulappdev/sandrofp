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
    final List<String> imageUrl;
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
            imageUrl: json["imageUrl"] == null ? [] : List<String>.from(json["imageUrl"]!.map((x) => x)),
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
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? user;
    final String? requestTo;
    final String? status;
    final List<ExchangeWith> products;
    final List<ExchangeWith> exchangeWith;
    final int? extraToken;
    final int? totalToken;
    final List<dynamic> reviewers;
    final dynamic reason;
    final bool? isReviewed;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Exchanges.fromJson(Map<String, dynamic> json){ 
        return Exchanges(
            id: json["_id"],
            user: json["user"],
            requestTo: json["requestTo"],
            status: json["status"],
            products: json["products"] == null ? [] : List<ExchangeWith>.from(json["products"]!.map((x) => ExchangeWith.fromJson(x))),
            exchangeWith: json["exchangeWith"] == null ? [] : List<ExchangeWith>.from(json["exchangeWith"]!.map((x) => ExchangeWith.fromJson(x))),
            extraToken: json["extraToken"],
            totalToken: json["totalToken"],
            reviewers: json["reviewers"] == null ? [] : List<dynamic>.from(json["reviewers"]!.map((x) => x)),
            reason: json["reason"],
            isReviewed: json["isReviewed"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class ExchangeWith {
    ExchangeWith({
        required this.location,
        required this.id,
        required this.images,
        required this.author,
        required this.name,
        required this.descriptions,
        required this.size,
        required this.brands,
        required this.materials,
        required this.colors,
        required this.tags,
        required this.isSoldOut,
        required this.isFeatured,
        required this.isVerified,
        required this.category,
        required this.price,
        required this.quantity,
        required this.discount,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final Location? location;
    final String? id;
    final List<Image> images;
    final String? author;
    final String? name;
    final String? descriptions;
    final String? size;
    final String? brands;
    final String? materials;
    final String? colors;
    final List<String> tags;
    final bool? isSoldOut;
    final bool? isFeatured;
    final bool? isVerified;
    final String? category;
    final int? price;
    final String? quantity;
    final int? discount;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ExchangeWith.fromJson(Map<String, dynamic> json){ 
        return ExchangeWith(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
            author: json["author"],
            name: json["name"],
            descriptions: json["descriptions"],
            size: json["size"],
            brands: json["brands"],
            materials: json["materials"],
            colors: json["colors"],
            tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
            isSoldOut: json["isSoldOut"],
            isFeatured: json["isFeatured"],
            isVerified: json["isVerified"],
            category: json["category"],
            price: json["price"],
            quantity: json["quantity"],
            discount: json["discount"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Image {
    Image({
        required this.key,
        required this.url,
        required this.id,
    });

    final String? key;
    final String? url;
    final String? id;

    factory Image.fromJson(Map<String, dynamic> json){ 
        return Image(
            key: json["key"],
            url: json["url"],
            id: json["_id"],
        );
    }

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
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
