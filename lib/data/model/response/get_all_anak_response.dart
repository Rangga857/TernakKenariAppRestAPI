import 'dart:convert';

class GetAllAnakResponse {
    final String? message;
    final int? statusCode;
    final List<Datum>? data;

    GetAllAnakResponse({
        this.message,
        this.statusCode,
        this.data,
    });

    factory GetAllAnakResponse.fromJson(String str) => GetAllAnakResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAllAnakResponse.fromMap(Map<String, dynamic> json) => GetAllAnakResponse(
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
    final String? noRing;
    final String? gambarBurung;
    final DateTime? tanggalLahir;
    final String? jenisKelamin;
    final String? jenisKenari;
    final String? ayahNoRing;
    final String? ibuNoRing;

    Datum({
        this.id,
        this.noRing,
        this.gambarBurung,
        this.tanggalLahir,
        this.jenisKelamin,
        this.jenisKenari,
        this.ayahNoRing,
        this.ibuNoRing,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        noRing: json["no_ring"],
        gambarBurung: json["gambar_burung"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        ayahNoRing: json["ayah_no_ring"],
        ibuNoRing: json["ibu_no_ring"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "no_ring": noRing,
        "gambar_burung": gambarBurung,
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "jenis_kenari": jenisKenari,
        "ayah_no_ring": ayahNoRing,
        "ibu_no_ring": ibuNoRing,
    };
}
