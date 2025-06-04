import 'dart:convert';

class BurungSemuaTersediaModel {
    final String? message;
    final int? statusCode;
    final List<Datum>? data;

    BurungSemuaTersediaModel({
        this.message,
        this.statusCode,
        this.data,
    });

    factory BurungSemuaTersediaModel.fromJson(String str) => BurungSemuaTersediaModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BurungSemuaTersediaModel.fromMap(Map<String, dynamic> json) => BurungSemuaTersediaModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    final int? id;
    final String? image;
    final String? noRing;
    final String? jenisKelamin;
    final String? usia;
    final String? jenisKenari;
    final int? harga;
    final String? deskripsi;
    final String? status;

    Datum({
        this.id,
        this.image,
        this.noRing,
        this.jenisKelamin,
        this.usia,
        this.jenisKenari,
        this.harga,
        this.deskripsi,
        this.status,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        noRing: json["no_ring"],
        jenisKelamin: json["jenis_kelamin"],
        usia: json["usia"],
        jenisKenari: json["jenis_kenari"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "no_ring": noRing,
        "jenis_kelamin": jenisKelamin,
        "usia": usia,
        "jenis_kenari": jenisKenari,
        "harga": harga,
        "deskripsi": deskripsi,
        "status": status,
    };
}
