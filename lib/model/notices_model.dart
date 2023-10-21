
import 'dart:convert';

List<NoticeModel> noticeModelFromJson(dynamic str) => List<NoticeModel>.from(str.map((x) => NoticeModel.fromJson(x)));

String noticeModelToJson(List<NoticeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoticeModel {
  int? id;
  String? thumbnail;
  String? title;
  String? summery;
  String? description;
  String? link;
  double? minCgpa;
  int? minBudget;
  int? countryId;
  int? universityId;
  int? maxAge;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? thumbnailFullUrl;
  bool? isSaved;
  List<dynamic>? languages;
  List<Tag>? tags;
  Country? country;
  University? university;

  NoticeModel({
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
    this.maxAge,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.thumbnailFullUrl,
    this.isSaved,
    this.languages,
    this.tags,
    this.country,
    this.university,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    id: json["id"],
    thumbnail: json["thumbnail"]??"",
    title: json["title"],
    summery: json["summery"],
    description: json["description"],
    link: json["link"],
    minCgpa: json["min_cgpa"]?.toDouble(),
    minBudget: json["min_budget"],
    countryId: json["country_id"],
    universityId: json["university_id"],
    maxAge: json["max_age"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    thumbnailFullUrl: json["thumbnail_full_url"]??"",
    isSaved: json["is_saved"],
    languages: json["languages"] == null ? [] : List<dynamic>.from(json["languages"]!.map((x) => x)),
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    university: json["university"] == null ? null : University.fromJson(json["university"]),
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
    "max_age": maxAge,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "thumbnail_full_url": thumbnailFullUrl,
    "is_saved": isSaved,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "country": country?.toJson(),
    "university": university?.toJson(),
  };
}

class Country {
  int? id;
  String? name;
  String? code;
  String? flag;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Country({
    this.id,
    this.name,
    this.code,
    this.flag,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    flag: json["flag"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "flag": flag,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Tag {
  int? id;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Pivot? pivot;

  Tag({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int? noticeId;
  int? tagId;

  Pivot({
    this.noticeId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    noticeId: json["notice_id"],
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "notice_id": noticeId,
    "tag_id": tagId,
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
  };
}
