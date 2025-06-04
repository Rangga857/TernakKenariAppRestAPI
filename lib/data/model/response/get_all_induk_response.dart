import 'dart:convert';

class GetAllIndukResponse {
    final String? message;
    final int? statusCode;
    final List<Datum>? data;

    GetAllIndukResponse({
        this.message,
        this.statusCode,
        this.data,
    });

    factory GetAllIndukResponse.fromJson(String str) => GetAllIndukResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAllIndukResponse.fromMap(Map<String, dynamic> json) => GetAllIndukResponse(
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
    final DateTime? tanggalLahir;
    final String? jenisKelamin;
    final String? jenisKenari;
    final String? keterangan;
    final String? gambarBurung;

    Datum({
        this.id,
        this.noRing,
        this.tanggalLahir,
        this.jenisKelamin,
        this.jenisKenari,
        this.keterangan,
        this.gambarBurung,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        noRing: json["no_ring"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        keterangan: json["keterangan"],
        gambarBurung: json["gambar_burung"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "no_ring": noRing,
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "jenis_kenari": jenisKenari,
        "keterangan": keterangan,
        "gambar_burung": gambarBurung,
    };
}
