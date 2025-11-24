class NotificationsModel {
    NotificationsModel({
        required this.success,
        required this.message,
        required this.data,
        required this.meta,
    });

    final bool? success;
    final String? message;
    final List<NotificationItemModel> data;
    final Meta? meta;

    factory NotificationsModel.fromJson(Map<String, dynamic> json){ 
        return NotificationsModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? [] : List<NotificationItemModel>.from(json["data"]!.map((x) => NotificationItemModel.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class NotificationItemModel {
    NotificationItemModel({
        required this.id,
        required this.receiver,
        required this.refference,
        required this.modelType,
        required this.message,
        required this.description,
        required this.read,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? receiver;
    final String? refference;
    final String? modelType;
    final String? message;
    final String? description;
    final bool? read;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory NotificationItemModel.fromJson(Map<String, dynamic> json){ 
        return NotificationItemModel(
            id: json["_id"],
            receiver: json["receiver"],
            refference: json["refference"],
            modelType: json["model_type"],
            message: json["message"],
            description: json["description"],
            read: json["read"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
