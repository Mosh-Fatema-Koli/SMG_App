
class MajorSubjectListModel {
  String id;
  String title;
  String subjectId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MajorSubjectListModel({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MajorSubjectListModel.fromJson(Map<String, dynamic> json) => MajorSubjectListModel(
    id: json["_id"],
    title: json["title"],
    subjectId: json["subject_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "subject_id": subjectId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
