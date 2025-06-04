import 'dart:convert';

class GetAllBurungResponseModel {
    final String? message;
    final int? statusCode;
    final List<Datum>? data;

    GetAllBurungResponseModel({
        this.message,
        this.statusCode,
        this.data,
    });

    factory GetAllBurungResponseModel.fromJson(String str) => GetAllBurungResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAllBurungResponseModel.fromMap(Map<String, dynamic> json) => GetAllBurungResponseModel(
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
    final Tipe? tipe;
    final String? noRing;
    final JenisKelamin? jenisKelamin;
    final DateTime? tanggalLahir;
    final JenisKenari? jenisKenari;

    Datum({
        this.id,
        this.tipe,
        this.noRing,
        this.jenisKelamin,
        this.tanggalLahir,
        this.jenisKenari,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tipe: tipeValues.map[json["tipe"]]!,
        noRing: json["no_ring"],
        jenisKelamin: jenisKelaminValues.map[json["jenis_kelamin"]]!,
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKenari: jenisKenariValues.map[json["jenis_kenari"]]!,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "tipe": tipeValues.reverse[tipe],
        "no_ring": noRing,
        "jenis_kelamin": jenisKelaminValues.reverse[jenisKelamin],
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kenari": jenisKenariValues.reverse[jenisKenari],
    };
}

enum JenisKelamin {
    BETINA,
    JANTAN
}

final jenisKelaminValues = EnumValues({
    "betina": JenisKelamin.BETINA,
    "jantan": JenisKelamin.JANTAN
});

enum JenisKenari {
    AF_MEDIUM,
    LOCAL
}

final jenisKenariValues = EnumValues({
    "AF Medium": JenisKenari.AF_MEDIUM,
    "Local": JenisKenari.LOCAL
});

enum Tipe {
    ANAK,
    INDUK
}

final tipeValues = EnumValues({
    "anak": Tipe.ANAK,
    "induk": Tipe.INDUK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
