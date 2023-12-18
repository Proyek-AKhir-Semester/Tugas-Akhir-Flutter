// To parse this JSON data, do
//
//     final peminjaman = peminjamanFromJson(jsonString);

import 'dart:convert';

List<Peminjaman> peminjamanFromJson(String str) => List<Peminjaman>.from(json.decode(str).map((x) => Peminjaman.fromJson(x)));

String peminjamanToJson(List<Peminjaman> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Peminjaman {
  String model;
  int pk;
  Fields fields;

  Peminjaman({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) => Peminjaman(
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
  int pengguna;
  String buku;
  DateTime tanggalPeminjaman;
  DateTime tanggalPengembalian;
  bool statusAcc;

  Fields({
    required this.pengguna,
    required this.buku,
    required this.tanggalPeminjaman,
    required this.tanggalPengembalian,
    required this.statusAcc,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    pengguna: json["pengguna"],
    buku: json["buku"],
    tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
    tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
    statusAcc: json["status_acc"],
  );

  Map<String, dynamic> toJson() => {
    "pengguna": pengguna,
    "buku": buku,
    "tanggal_peminjaman": "${tanggalPeminjaman.year.toString().padLeft(4, '0')}-${tanggalPeminjaman.month.toString().padLeft(2, '0')}-${tanggalPeminjaman.day.toString().padLeft(2, '0')}",
    "tanggal_pengembalian": "${tanggalPengembalian.year.toString().padLeft(4, '0')}-${tanggalPengembalian.month.toString().padLeft(2, '0')}-${tanggalPengembalian.day.toString().padLeft(2, '0')}",
    "status_acc": statusAcc,
  };
}
