// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

List<BlogModel> blogModelFromJson(dynamic str) => List<BlogModel>.from(str.map((x) => BlogModel.fromJson(x)));

String blogModelToJson(List<BlogModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogModel {
  int? id;
  String? title;
  String? summery;
  String? body;
  bool? isSaved;
  int? authorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? thumbnail;
  String? subscriptionKind;
  String? publicationKind;
  String? thumbnailFullUrl;

  List<Tag>? tags;

  BlogModel({
    this.id,
    this.title,
    this.summery,
    this.body,
    this.authorId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.thumbnail,
    this.subscriptionKind,
    this.publicationKind,
    this.thumbnailFullUrl,
    this.tags,
    this.isSaved,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json["id"],
    title: json["title"],
    summery: json["summery"],
    body: json["body"],
    isSaved: json["is_saved"],
    authorId: json["author_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    thumbnail: json["thumbnail"],
    subscriptionKind: json["subscription_kind"],
    publicationKind: json["publication_kind"],
    thumbnailFullUrl: json["thumbnail_full_url"],
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "summery": summery,
    "body": body,
    "author_id": authorId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "thumbnail": thumbnail,
    "subscription_kind": subscriptionKind,
    "publication_kind": publicationKind,
    "thumbnail_full_url": thumbnailFullUrl,
    "is_saved":isSaved,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
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
  int? blogId;
  int? tagId;

  Pivot({
    this.blogId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    blogId: json["blog_id"],
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "blog_id": blogId,
    "tag_id": tagId,
  };
}
