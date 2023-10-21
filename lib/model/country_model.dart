// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryModelFromJson(dynamic str) => List<CountryModel>.from(str.map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  String? id;
  String? flag;
  String? shortname;
  String? name;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  CountryModel({
    this.id,
    this.flag,
    this.shortname,
    this.name,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["_id"],
    flag: json["flag"],
    shortname: json["shortname"],
    name: json["name"],
    v: json["__v"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "flag": flag,
    "shortname": shortname,
    "name": name,
    "__v": v,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
