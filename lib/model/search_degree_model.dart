// To parse this JSON data, do
//
//     final searchDegreeModel = searchDegreeModelFromJson(jsonString);

import 'dart:convert';

List<SearchDegreeModel> searchDegreeModelFromJson(String str) => List<SearchDegreeModel>.from(json.decode(str).map((x) => SearchDegreeModel.fromJson(x)));

String searchDegreeModelToJson(List<SearchDegreeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchDegreeModel {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SearchDegreeModel({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SearchDegreeModel.fromJson(Map<String, dynamic> json) => SearchDegreeModel(
    id: json["_id"],
    title: json["title"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
