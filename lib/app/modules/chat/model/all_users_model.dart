class AllUsersModel {
    AllUsersModel({
        required this.success,
        required this.message,
        required this.meta, 
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<AllUsersItemModel> data;

    factory AllUsersModel.fromJson(Map<String, dynamic> json){ 
        return AllUsersModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllUsersItemModel>.from(json["data"]!.map((x) => AllUsersItemModel.fromJson(x))),
        );
    }

}

class AllUsersItemModel {
    AllUsersItemModel({
        required this.id,
        required this.name,
        required this.email,
        required this.username,
        required this.photoUrl,
        required this.banner,
        required this.status,
        required this.datumId,
        required this.createdAt,
        required this.updatedAt,
        required this.isFollowing,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? username;
    final String? photoUrl;
    final String? banner;
    final String? status;
    final String? datumId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isFollowing;

    factory AllUsersItemModel.fromJson(Map<String, dynamic> json){ 
        return AllUsersItemModel(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            username: json["username"],
            photoUrl: json["photoUrl"],
            banner: json["banner"],
            status: json["status"],
            datumId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            isFollowing: json["isFollowing"],
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
