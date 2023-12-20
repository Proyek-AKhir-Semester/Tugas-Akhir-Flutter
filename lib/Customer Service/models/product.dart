// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

List<Report> reportFromJson(String str) => List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportToJson(List<Report> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
    String model;
    int pk;
    Fields fields;

    Report({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
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
    int user;
    String losts;
    String brokens;
    DateTime reportDate;
    String status;
    String message;

    Fields({
        required this.user,
        required this.losts,
        required this.brokens,
        required this.reportDate,
        required this.status,
        required this.message,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        losts: json["losts"],
        brokens: json["brokens"],
        reportDate: DateTime.parse(json["report_date"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "losts": losts,
        "brokens": brokens,
        "report_date": "${reportDate.year.toString().padLeft(4, '0')}-${reportDate.month.toString().padLeft(2, '0')}-${reportDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "message": message,
    };
}