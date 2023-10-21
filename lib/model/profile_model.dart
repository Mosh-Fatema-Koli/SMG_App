
class User {
  int? id;
  String name;
  String email;
  String phone;
  dynamic dob;
  dynamic nationality;
  dynamic gender;
  String? status;
  dynamic deviceToken;
  String? baseHouse;
  String? token;
  String image;
  List<dynamic>? publications;
  StudentProfile? studentProfile;
  EntAddress? currentAddress;
  EntAddress? permanentAddress;

  User({
     this.id,
     required this.name,
     required this.email,
     required this.phone,
     this.dob,
     this.nationality,
     this.gender,
     this.status,
     this.deviceToken,
     this.baseHouse,
     this.token,
     this.publications,
     this.studentProfile,
    this.currentAddress,
    this.permanentAddress,
     required this.image,

  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"]??"",
    email: json["email"]??"",
    phone: json["phone"]??"",
    dob: json["dob"],
    nationality: json["nationality"],
    gender: json["gender"],
    status: json["status"],
    deviceToken: json["device_token"],
    baseHouse: json["base_house"],
    token: json["token"],
    image: json["image"]??"",
    publications:json["publications"]==null?[]:List<dynamic>.from(json["publications"].map((x) => x)),
    currentAddress: json["current_address"] == null ? null : EntAddress.fromJson(json["current_address"]),
    permanentAddress: json["permanent_address"] == null ? null : EntAddress.fromJson(json["permanent_address"]),
    studentProfile: StudentProfile.fromJson(json["student_profile"]),
  );
}


class EntAddress {
  int? id;
  String? address;
  int? divisionId;
  int? districtId;
  String? zipCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  District? division;
  District? district;

  EntAddress({
    this.id,
    this.address,
    this.divisionId,
    this.districtId,
    this.zipCode,
    this.createdAt,
    this.updatedAt,
    this.division,
    this.district,
  });

  factory EntAddress.fromJson(Map<String, dynamic> json) => EntAddress(
    id: json["id"],
    address: json["address"],
    divisionId: json["division_id"],
    districtId: json["district_id"],
    zipCode: json["zip_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    division: json["division"] == null ? null : District.fromJson(json["division"]),
    district: json["district"] == null ? null : District.fromJson(json["district"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "division_id": divisionId,
    "district_id": districtId,
    "zip_code": zipCode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "division": division?.toJson(),
    "district": district?.toJson(),
  };
}

class District {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  District({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class StudentProfile {
  int id;
  String firstname;
  String middlename;
  String lastname;
  String fatherName;
  String motherName;
  DateTime dob;
  dynamic nid;
  dynamic passportNumber;
  dynamic policeVerification;
  dynamic nationality;
  // dynamic currentAddress;
  // dynamic permanentAddress;
  int lastDegreeId;
  int userId;
  int budget;
  List<Degree> degrees;
  List<Language> languages;
  List<DesiredCountry>? desiredCountry;

  StudentProfile({
    required this.id,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.fatherName,
    required this.motherName,
    required this.dob,
    required this.nid,
    required this.passportNumber,
    required this.policeVerification,
    required this.nationality,

    required this.lastDegreeId,
    required this.userId,
    required this.budget,
    required this.degrees,
    required this.languages,
    this.desiredCountry,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
    id: json["id"],
    firstname: json["firstname"]??"",
    middlename: json["middlename"]??"",
    lastname: json["lastname"]??"",
    fatherName: json["father_name"]??"",
    motherName: json['mother_name']??"",
    dob: DateTime.parse(json["dob"]),
    nid: json["nid"],
    passportNumber: json["passport_number"],
    policeVerification: json["police_verification"],
    nationality: json["nationality"],

    userId: json["user_id"],
    budget: json["budget"],
    degrees:json["degrees"]==null?[]:List<Degree>.from(json["degrees"].map((x) => Degree.fromJson(x))),
    languages:json["languages"]==null?[]:List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    lastDegreeId: json['last_degree_id'],
    desiredCountry:json["desired_countries"]==null?[]:List<DesiredCountry>.from(json["desired_countries"].map((x) => DesiredCountry.fromJson(x))),
  );
}

class Degree {
  int id;
  String name;
  dynamic reference;
  dynamic level;
  int status;
  DegreePivot pivot;

  Degree({
    required this.id,
    required this.name,
    required this.reference,
    required this.level,
    required this.status,
    required this.pivot,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    id: json["id"],
    name: json["name"],
    reference: json["reference"],
    level: json["level"],
    status: json["status"],
    pivot: DegreePivot.fromJson(json["pivot"]),
  );

}

class DegreePivot {
  int profileId;
  int degreeId;
  dynamic gpa;
  dynamic scorePercentage;
  dynamic maxGpa;
  dynamic minGpa;
  dynamic passingYear;
  dynamic startingYear;

  DegreePivot({
    required this.profileId,
    required this.degreeId,
    required this.gpa,
    required this.scorePercentage,
    required this.maxGpa,
    required this.minGpa,
    required this.passingYear,
    required this.startingYear,
  });

  factory DegreePivot.fromJson(Map<String, dynamic> json) => DegreePivot(
    profileId: json["profile_id"],
    degreeId: json["degree_id"],
    gpa: json["gpa"],
    scorePercentage: json["score_percentage"],
    maxGpa: json["max_gpa"],
    minGpa: json["min_gpa"],
    passingYear:json["passing_year"],
    startingYear: json["starting_year"],
  );

}

class Language {
  int id;
  String name;
  int status;
  LanguagePivot pivot;

  Language({
    required this.id,
    required this.name,
    required this.status,
    required this.pivot,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    pivot: LanguagePivot.fromJson(json["pivot"]),
  );

}

class LanguagePivot {
  int profileId;
  int languageId;
  dynamic level;
  dynamic score;

  LanguagePivot({
    required this.profileId,
    required this.languageId,
    required this.level,
    required this.score,
  });

  factory LanguagePivot.fromJson(Map<String, dynamic> json) => LanguagePivot(
    profileId: json["profile_id"],
    languageId: json["language_id"],
    level: json["level"],
    score: json["score"],
  );

}



class DesiredCountry {
  int id;
  String name;
  String flag;
  int status;
  Pivot pivot;

  DesiredCountry({
    required this.id,
    required this.name,
    required this.status,
    required this.pivot,
    required this.flag,
  });

  factory DesiredCountry.fromJson(Map<String, dynamic> json) => DesiredCountry(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    pivot: Pivot.fromJson(json["pivot"]),
    flag: json["flag"]??"",
  );
}
class Pivot {
  int profileId;
  int countryId;

  Pivot({
    required this.profileId,
    required this.countryId,
  });
  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    profileId: json["profile_id"],
    countryId: json["country_id"],
  );


}


class DesiredDegreeModel {
  int? id;
  String? name;
  String? reference;
  String? level;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  DesiredPivot? pivot;

  DesiredDegreeModel({
    this.id,
    this.name,
    this.reference,
    this.level,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot
  });
  factory DesiredDegreeModel.fromJson(Map<String, dynamic> json) => DesiredDegreeModel(
    id: json["id"],
    name: json["name"],
    reference: json["reference"],
    level: json["level"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: json["pivot"] == null ? null : DesiredPivot.fromJson(json["pivot"]),
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
class DesiredPivot {
  int profileId;
  int degreeId;

  DesiredPivot({
    required this.profileId,
    required this.degreeId,
  });
  factory DesiredPivot.fromJson(Map<String, dynamic> json) => DesiredPivot(
    profileId: json["profile_id"],
    degreeId: json["degree_id"],
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "degree_id": degreeId,
  };


}





class UserPersonalInformation {
  Nid nid;
  Passport passport;
  Addresses addresses;
  SocialLinks socialLinks;
  String id;
  String userId;
  String firstName;
  dynamic middleName;
  String lastName;
  dynamic photo;
  dynamic email;
  dynamic phone;
  dynamic parentNameMale;
  dynamic parentNameFemale;
  String gender;
  DateTime dob;
  dynamic maritalStatus;
  dynamic nationality;
  dynamic religion;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UserPersonalInformation({
    required this.nid,
    required this.passport,
    required this.addresses,
    required this.socialLinks,
    required this.id,
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.photo,
    required this.email,
    required this.phone,
    required this.parentNameMale,
    required this.parentNameFemale,
    required this.gender,
    required this.dob,
    required this.maritalStatus,
    required this.nationality,
    required this.religion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserPersonalInformation.fromJson(Map<String, dynamic> json) => UserPersonalInformation(
    nid: Nid.fromJson(json["nid"]),
    passport: Passport.fromJson(json["passport"]),
    addresses: Addresses.fromJson(json["addresses"]),
    socialLinks: SocialLinks.fromJson(json["social_links"]),
    id: json["_id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    photo: json["photo"],
    email: json["email"],
    phone: json["phone"],
    parentNameMale: json["parent_name_male"],
    parentNameFemale: json["parent_name_female"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    maritalStatus: json["marital_status"],
    nationality: json["nationality"],
    religion: json["religion"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "nid": nid.toJson(),
    "passport": passport.toJson(),
    "addresses": addresses.toJson(),
    "social_links": socialLinks.toJson(),
    "_id": id,
    "user_id": userId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "photo": photo,
    "email": email,
    "phone": phone,
    "parent_name_male": parentNameMale,
    "parent_name_female": parentNameFemale,
    "gender": gender,
    "dob": dob.toIso8601String(),
    "marital_status": maritalStatus,
    "nationality": nationality,
    "religion": religion,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Addresses {
  Address currentAddress;
  Address permanentAddress;
  Address mailingAddress;

  Addresses({
    required this.currentAddress,
    required this.permanentAddress,
    required this.mailingAddress,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
    currentAddress: Address.fromJson(json["current_address"]),
    permanentAddress: Address.fromJson(json["permanent_address"]),
    mailingAddress: Address.fromJson(json["mailing_address"]),
  );

  Map<String, dynamic> toJson() => {
    "current_address": currentAddress.toJson(),
    "permanent_address": permanentAddress.toJson(),
    "mailing_address": mailingAddress.toJson(),
  };
}

class Address {
  dynamic address;
  dynamic district;
  dynamic subDistrict;
  dynamic postOffice;
  dynamic postCode;
  dynamic division;

  Address({
    required this.address,
    required this.district,
    required this.subDistrict,
    required this.postOffice,
    required this.postCode,
    required this.division,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    district: json["district"],
    subDistrict: json["sub_district"],
    postOffice: json["post_office"],
    postCode: json["post_code"],
    division: json["division"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "district": district,
    "sub_district": subDistrict,
    "post_office": postOffice,
    "post_code": postCode,
    "division": division,
  };
}

class Nid {
  dynamic nidNumber;
  dynamic nidPhotoFront;
  dynamic nidPhotoBack;

  Nid({
    required this.nidNumber,
    required this.nidPhotoFront,
    required this.nidPhotoBack,
  });

  factory Nid.fromJson(Map<String, dynamic> json) => Nid(
    nidNumber: json["nid_number"],
    nidPhotoFront: json["nid_photo_front"],
    nidPhotoBack: json["nid_photo_back"],
  );

  Map<String, dynamic> toJson() => {
    "nid_number": nidNumber,
    "nid_photo_front": nidPhotoFront,
    "nid_photo_back": nidPhotoBack,
  };
}

class Passport {
  dynamic passportNumber;
  dynamic passportPhoto;

  Passport({
    required this.passportNumber,
    required this.passportPhoto,
  });

  factory Passport.fromJson(Map<String, dynamic> json) => Passport(
    passportNumber: json["passport_number"],
    passportPhoto: json["passport_photo"],
  );

  Map<String, dynamic> toJson() => {
    "passport_number": passportNumber,
    "passport_photo": passportPhoto,
  };
}

class SocialLinks {
  dynamic facebook;
  dynamic twitter;
  dynamic linkedin;
  dynamic instagram;
  dynamic youtube;

  SocialLinks({
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.youtube,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
    facebook: json["facebook"],
    twitter: json["twitter"],
    linkedin: json["linkedin"],
    instagram: json["instagram"],
    youtube: json["youtube"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "twitter": twitter,
    "linkedin": linkedin,
    "instagram": instagram,
    "youtube": youtube,
  };
}
