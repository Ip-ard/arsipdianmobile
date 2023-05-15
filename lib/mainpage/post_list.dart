// To parse this JSON data, do
//
//     final postList = postListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostList postListFromJson(String str) => PostList.fromJson(json.decode(str));

String postListToJson(PostList data) => json.encode(data.toJson());

class PostList {
  final List<Datum> data;

  PostList({
    required this.data,
  });

  factory PostList.fromJson(Map<String, dynamic> json) => PostList(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String atasNama;
  final DateTime tanggalPembuatan;
  final String keterangan;
  final String document;
  final String createdAt;
  final int penulis;
  final Writer writer;

  Datum({
    required this.id,
    required this.atasNama,
    required this.tanggalPembuatan,
    required this.keterangan,
    required this.document,
    required this.createdAt,
    required this.penulis,
    required this.writer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    atasNama: json["atas_nama"],
    tanggalPembuatan: DateTime.parse(json["tanggal_pembuatan"]),
    keterangan: json["keterangan"],
    document: json["document"],
    createdAt: json["created_at"],
    penulis: json["penulis"],
    writer: Writer.fromJson(json["writer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "atas_nama": atasNama,
    "tanggal_pembuatan": "${tanggalPembuatan.year.toString().padLeft(4, '0')}-${tanggalPembuatan.month.toString().padLeft(2, '0')}-${tanggalPembuatan.day.toString().padLeft(2, '0')}",
    "keterangan": keterangan,
    "document": document,
    "created_at": createdAt,
    "penulis": penulis,
    "writer": writer.toJson(),
  };
}

class Writer {
  final int id;
  final Username username;

  Writer({
    required this.id,
    required this.username,
  });

  factory Writer.fromJson(Map<String, dynamic> json) => Writer(
    id: json["id"],
    username: usernameValues.map[json["username"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": usernameValues.reverse[username],
  };
}

enum Username { RAHASIA, RAHASIA2, RAHASIA3 }

final usernameValues = EnumValues({
  "rahasia": Username.RAHASIA,
  "rahasia2": Username.RAHASIA2,
  "rahasia3": Username.RAHASIA3
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
