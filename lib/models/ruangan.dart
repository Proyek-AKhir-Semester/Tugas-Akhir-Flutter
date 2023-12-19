// To parse this JSON data, do
//
//     final ruangan = ruanganFromJson(jsonString);

import 'dart:convert';

List<Ruangan> ruanganFromJson(String str) => List<Ruangan>.from(json.decode(str).map((x) => Ruangan.fromJson(x)));

String ruanganToJson(List<Ruangan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ruangan {
  String model;
  int pk;
  Fields fields;

  Ruangan({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Ruangan.fromJson(Map<String, dynamic> json) => Ruangan(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int nomor;
  String ketersediaan;

  Fields({
    required this.nomor,
    required this.ketersediaan,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    nomor: json["nomor"],
    ketersediaan: json["ketersediaan"],
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "ketersediaan": ketersediaan,
  };
}
