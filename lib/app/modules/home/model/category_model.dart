class CategoryModel {
    CategoryModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final CategoryData? data;

    factory CategoryModel.fromJson(Map<String, dynamic> json){ 
        return CategoryModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : CategoryData.fromJson(json["data"]),
        );
    }

}

class CategoryData {
    CategoryData({
        required this.data,
        required this.meta,
    });

    final List<Datum> data;
    final Meta? meta;

    factory CategoryData.fromJson(Map<String, dynamic> json){ 
        return CategoryData(
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.banner,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? name;
    final String? banner;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            name: json["name"],
            banner: json["banner"],
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
