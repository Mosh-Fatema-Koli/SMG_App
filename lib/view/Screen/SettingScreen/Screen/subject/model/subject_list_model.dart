class SubjectListModel {
  String id;
  String title;
  String degreeId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SubjectListModel({
    required this.id,
    required this.title,
    required this.degreeId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SubjectListModel.fromJson(Map<String, dynamic> json) => SubjectListModel(
    id: json["_id"],
    title: json["title"],
    degreeId: json["degree_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "degree_id": degreeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}
