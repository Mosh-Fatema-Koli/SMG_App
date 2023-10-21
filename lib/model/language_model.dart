
class LanguageModel {
  int id;
  String name;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<LanguageModel> levels;
  int? languageId;

  LanguageModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.levels,
    this.languageId,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    levels: json["levels"] == null ? [] : List<LanguageModel>.from(json["levels"]!.map((x) => LanguageModel.fromJson(x))),
    languageId: json["language_id"],
  );


}
