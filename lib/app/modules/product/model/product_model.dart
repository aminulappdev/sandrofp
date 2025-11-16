class AllProductModel {
    AllProductModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory AllProductModel.fromJson(Map<String, dynamic> json){ 
        return AllProductModel(
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

    final List<AllProductItemModel> data;
    final Meta? meta;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            data: json["data"] == null ? [] : List<AllProductItemModel>.from(json["data"]!.map((x) => AllProductItemModel.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class AllProductItemModel {
    AllProductItemModel({
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
    });

    final Location? location;
    final String? id;
    final List<Image> images;
    final Author? author;
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
    final Category? category;
    final dynamic price;
    final String? quantity;
    final dynamic discount;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory AllProductItemModel.fromJson(Map<String, dynamic> json){ 
        return AllProductItemModel(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
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
            category: json["category"] == null ? null : Category.fromJson(json["category"]),
            price: json["price"],
            quantity: json["quantity"],
            discount: json["discount"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class Author {
    Author({
        required this.id,
        required this.name,
        required this.email,
        required this.profile,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? profile;

    factory Author.fromJson(Map<String, dynamic> json){ 
        return Author(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            profile: json["profile"],
        );
    }

}

class Category {
    Category({
        required this.id,
        required this.name,
        required this.banner,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? name;
    final String? banner;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["_id"],
            name: json["name"],
            banner: json["banner"],
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
