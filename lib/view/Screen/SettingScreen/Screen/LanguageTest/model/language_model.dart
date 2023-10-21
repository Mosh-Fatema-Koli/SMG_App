// class LanguageModel {
//   String? sId;
//   String? title;
//   String? shortTitle;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   LanguageModel(
//       {this.sId,
//         this.title,
//         this.shortTitle,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   LanguageModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     shortTitle = json['short_title'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['short_title'] = this.shortTitle;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }