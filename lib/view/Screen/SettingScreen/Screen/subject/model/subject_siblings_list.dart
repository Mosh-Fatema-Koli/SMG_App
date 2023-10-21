class SubjectSiblingListModel {
  String id;
  String subjectId;
  String siblingSubjectId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SubjectSiblingListModel({
    required this.id,
    required this.subjectId,
    required this.siblingSubjectId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SubjectSiblingListModel.fromJson(Map<String, dynamic> json) => SubjectSiblingListModel(
    id: json["_id"],
    subjectId: json["subject_id"],
    siblingSubjectId: json["sibling_subject_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subject_id": subjectId,
    "sibling_subject_id": siblingSubjectId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
