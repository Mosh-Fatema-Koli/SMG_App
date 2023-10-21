// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

import 'dart:convert';

List<MatchModel> matchModelFromJson(dynamic str) => List<MatchModel>.from(str.map((x) => MatchModel.fromJson(x)));

String matchModelToJson(List<MatchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

class MatchModel {
  int? id;
  int? noticeId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic isRated;
  Notice? notice;
  List<MatchReason>? matchReasons;

  MatchModel({
    this.id,
    this.noticeId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.isRated,
    this.notice,
    this.matchReasons,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    id: json["id"],
    noticeId: json["notice_id"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isRated: json["is_rated"],
    notice: json["notice"] == null ? null : Notice.fromJson(json["notice"]),
    matchReasons: json["match_reasons"] == null ? [] : List<MatchReason>.from(json["match_reasons"]!.map((x) => MatchReason.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notice_id": noticeId,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_rated": isRated,
    "notice": notice?.toJson(),
    "match_reasons": matchReasons == null ? [] : List<dynamic>.from(matchReasons!.map((x) => x.toJson())),
  };
}

class MatchReason {
  int? id;
  int? matchId;
  String? reasonAttribute;
  String? reasonValue;
  dynamic details;
  DateTime? createdAt;
  DateTime? updatedAt;

  MatchReason({
    this.id,
    this.matchId,
    this.reasonAttribute,
    this.reasonValue,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory MatchReason.fromJson(Map<String, dynamic> json) => MatchReason(
    id: json["id"],
    matchId: json["match_id"],
    reasonAttribute: json["reason_attribute"],
    reasonValue: json["reason_value"],
    details: json["details"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "match_id": matchId,
    "reason_attribute": reasonAttribute,
    "reason_value": reasonValue,
    "details": details,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Notice {
  int? id;
  String? thumbnail;
  String? title;
  String? summery;
  String? description;
  String? link;
  int? minCgpa;
  int? minBudget;
  int? countryId;
  int? universityId;
  int? departmentId;
  int? maxAge;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? thumbnailFullUrl;
  bool? isSaved;
  List<Degree>? degrees;
  University? university;
  Department? department;
  List<Requirement>? requirements;

  Notice({
    this.id,
    this.thumbnail,
    this.title,
    this.summery,
    this.description,
    this.link,
    this.minCgpa,
    this.minBudget,
    this.countryId,
    this.universityId,
    this.departmentId,
    this.maxAge,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.thumbnailFullUrl,
    this.isSaved,
    this.degrees,
    this.university,
    this.department,
    this.requirements,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    id: json["id"],
    thumbnail: json["thumbnail"],
    title: json["title"],
    summery: json["summery"],
    description: json["description"],
    link: json["link"],
    minCgpa: json["min_cgpa"],
    minBudget: json["min_budget"],
    countryId: json["country_id"],
    universityId: json["university_id"],
    departmentId: json["department_id"],
    maxAge: json["max_age"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    thumbnailFullUrl: json["thumbnail_full_url"],
    isSaved: json["is_saved"],
    degrees: json["degrees"] == null ? [] : List<Degree>.from(json["degrees"]!.map((x) => Degree.fromJson(x))),
    university: json["university"] == null ? null : University.fromJson(json["university"]),
    department: json["department"] == null ? null : Department.fromJson(json["department"]),
    requirements: json["requirements"] == null ? [] : List<Requirement>.from(json["requirements"]!.map((x) => Requirement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnail": thumbnail,
    "title": title,
    "summery": summery,
    "description": description,
    "link": link,
    "min_cgpa": minCgpa,
    "min_budget": minBudget,
    "country_id": countryId,
    "university_id": universityId,
    "department_id": departmentId,
    "max_age": maxAge,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "thumbnail_full_url": thumbnailFullUrl,
    "is_saved": isSaved,
    "degrees": degrees == null ? [] : List<dynamic>.from(degrees!.map((x) => x.toJson())),
    "university": university?.toJson(),
    "department": department?.toJson(),
    "requirements": requirements == null ? [] : List<dynamic>.from(requirements!.map((x) => x.toJson())),
  };
}

class Degree {
  int? id;
  String? name;
  String? reference;
  String? level;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Pivot? pivot;

  Degree({
    this.id,
    this.name,
    this.reference,
    this.level,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    id: json["id"],
    name: json["name"],
    reference: json["reference"],
    level: json["level"]??"",
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "reference": reference,
    "level": level,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "pivot": pivot?.toJson(),
  };
}



class Pivot {
  int? noticeId;
  int? degreeId;

  Pivot({
    this.noticeId,
    this.degreeId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    noticeId: json["notice_id"],
    degreeId: json["degree_id"],
  );

  Map<String, dynamic> toJson() => {
    "notice_id": noticeId,
    "degree_id": degreeId,
  };
}

class Department {
  int? id;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Department({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Requirement {
  int? id;
  int? noticeId;
  String? key;
  String? value;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Requirement({
    this.id,
    this.noticeId,
    this.key,
    this.value,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
    id: json["id"],
    noticeId: json["notice_id"],
    key: json["key"],
    value: json["value"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notice_id": noticeId,
    "key": key,
    "value": value,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class University {
  int? id;
  String? title;
  dynamic image;
  int? countryId;
  dynamic rank;
  String? website;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Country country;


  University({
    this.id,
    this.title,
    this.image,
    this.countryId,
    this.rank,
    this.website,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    required this.country,
  });

  factory University.fromJson(Map<String, dynamic> json) => University(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    countryId: json["country_id"],
    rank: json["rank"],
    website: json["website"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "country_id": countryId,
    "rank": rank,
    "website": website,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "country": country.toJson(),
  };


}

class Country {
  int id;
  String name;
  String code;
  String flag;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"]??"",
    code: json["code"]??"",
    flag: json["flag"]??"",
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "flag": flag,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

