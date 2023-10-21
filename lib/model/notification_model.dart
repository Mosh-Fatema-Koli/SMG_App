class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? thumbnail;
  String? type;
  int? objectId;
  int? userId;
  String? objectType;
  DateTime? seenAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? thumbnailFullUrl;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.type,
    this.objectId,
    this.userId,
    this.objectType,
    this.seenAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.thumbnailFullUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    type: json["type"],
    objectId: json["object_id"],
    userId: json["user_id"],
    objectType: json["object_type"],
    seenAt: json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    thumbnailFullUrl: json["thumbnail_full_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "thumbnail": thumbnail,
    "type": type,
    "object_id": objectId,
    "user_id": userId,
    "object_type": objectType,
    "seen_at": "${seenAt!.year.toString().padLeft(4, '0')}-${seenAt!.month.toString().padLeft(2, '0')}-${seenAt!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "thumbnail_full_url": thumbnailFullUrl,
  };
}