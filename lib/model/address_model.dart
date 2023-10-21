// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(dynamic str) => AddressModel.fromJson(str);

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  String kind;
  String msg;
  Data data;

  AddressModel({
    required this.kind,
    required this.msg,
    required this.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    kind: json["kind"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  List<Division> divisions;

  Data({
    required this.divisions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    divisions: List<Division>.from(json["divisions"].map((x) => Division.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
  };
}

class Division {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  List<Division>? districts;
  int? divisionId;

  Division({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.districts,
    this.divisionId,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    districts: json["districts"] == null ? [] : List<Division>.from(json["districts"]!.map((x) => Division.fromJson(x))),
    divisionId: json["division_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "districts": districts == null ? [] : List<dynamic>.from(districts!.map((x) => x.toJson())),
    "division_id": divisionId,
  };
}
