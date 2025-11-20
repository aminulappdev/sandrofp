class MyFeedbackModel {
    MyFeedbackModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory MyFeedbackModel.fromJson(Map<String, dynamic> json){ 
        return MyFeedbackModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.data,
        required this.meta,
    });

    final List<MyFeedbackItemModel> data;
    final Meta? meta;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            data: json["data"] == null ? [] : List<MyFeedbackItemModel>.from(json["data"]!.map((x) => MyFeedbackItemModel.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class MyFeedbackItemModel {
    MyFeedbackItemModel({
        required this.id,
        required this.user,
        required this.seller,
        required this.review,
        required this.title,
        required this.rating,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final Seller? user;
    final Seller? seller;
    final String? review;
    final String? title;
    final dynamic rating;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory MyFeedbackItemModel.fromJson(Map<String, dynamic> json){ 
        return MyFeedbackItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : Seller.fromJson(json["user"]),
            seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
            review: json["review"],
            title: json["title"],
            rating: json["rating"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class Seller {
    Seller({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.profile,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? phoneNumber;
    final String? profile;

    factory Seller.fromJson(Map<String, dynamic> json){ 
        return Seller(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            profile: json["profile"],
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
