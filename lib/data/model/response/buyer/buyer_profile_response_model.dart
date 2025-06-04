import 'dart:convert';

class BuyerProfileResponseModel {
    final String? message;
    final int? statusCode;
    final Data? data;

    BuyerProfileResponseModel({
        this.message,
        this.statusCode,
        this.data,
    });

    factory BuyerProfileResponseModel.fromJson(String str) => BuyerProfileResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BuyerProfileResponseModel.fromMap(Map<String, dynamic> json) => BuyerProfileResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "data": data?.toMap(),
    };
}

class Data {
    final int? id;
    final String? name;
    final String? address;
    final String? phone;
    final String? photo;

    Data({
        this.id,
        this.name,
        this.address,
        this.phone,
        this.photo,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        photo: json["photo"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "photo": photo,
    };
}
