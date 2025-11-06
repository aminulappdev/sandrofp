class ProfileModel {
    ProfileModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ProfileData? data;

    factory ProfileModel.fromJson(Map<String, dynamic> json){ 
        return ProfileModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
        );
    }

}

class ProfileData {
    ProfileData({
        required this.location,
        required this.verification,
        required this.device,
        required this.id,
        required this.status,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.password,
        required this.gender,
        required this.dateOfBirth,
        required this.profile,
        required this.hobby,
        required this.language,
        required this.avgRating,
        required this.sellerType,
        required this.totalReview,
        required this.about,
        required this.customerId,
        required this.role,
        required this.loginWth,
        required this.address,
        required this.tokens,
        required this.isDeleted,
        required this.expireAt,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final Location? location;
    final Verification? verification;
    final Device? device;
    final String? id;
    final String? status;
    final String? name;
    final String? email;
    final String? phoneNumber;
    final String? password;
    final dynamic gender;
    final dynamic dateOfBirth;
    final String? profile;
    final dynamic hobby;
    final dynamic language;
    final int? avgRating;
    final dynamic sellerType;
    final int? totalReview;
    final dynamic about;
    final dynamic customerId;
    final String? role;
    final String? loginWth;
    final dynamic address;
    final int? tokens;
    final bool? isDeleted;
    final dynamic expireAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ProfileData.fromJson(Map<String, dynamic> json){ 
        return ProfileData(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
            device: json["device"] == null ? null : Device.fromJson(json["device"]),
            id: json["_id"],
            status: json["status"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            password: json["password"],
            gender: json["gender"],
            dateOfBirth: json["dateOfBirth"],
            profile: json["profile"],
            hobby: json["hobby"],
            language: json["language"],
            avgRating: json["avgRating"],
            sellerType: json["sellerType"],
            totalReview: json["totalReview"],
            about: json["about"],
            customerId: json["customerId"],
            role: json["role"],
            loginWth: json["loginWth"],
            address: json["address"],
            tokens: json["tokens"],
            isDeleted: json["isDeleted"],
            expireAt: json["expireAt"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Device {
    Device({
        required this.ip,
        required this.device,
        required this.lastLogin,
    });

    final String? ip;
    final String? device;
    final DateTime? lastLogin;

    factory Device.fromJson(Map<String, dynamic> json){ 
        return Device(
            ip: json["ip"],
            device: json["device"],
            lastLogin: DateTime.tryParse(json["lastLogin"] ?? ""),
        );
    }

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<dynamic> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
        );
    }

}

class Verification {
    Verification({
        required this.otp,
        required this.expiresAt,
        required this.status,
    });

    final String? otp;
    final DateTime? expiresAt;
    final bool? status;

    factory Verification.fromJson(Map<String, dynamic> json){ 
        return Verification(
            otp: json["otp"],
            expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
            status: json["status"],
        );
    }

}
