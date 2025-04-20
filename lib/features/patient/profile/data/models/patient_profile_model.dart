import 'dart:convert';

PatientProfileModel patientProfileModelFromJson(String str) => PatientProfileModel.fromJson(json.decode(str));

String patientProfileModelToJson(PatientProfileModel data) => json.encode(data.toJson());

class PatientProfileModel {
  final User? user;
  final int? id;
  final String? chronicDiseases;

  PatientProfileModel({
    this.user,
    this.id,
    this.chronicDiseases,
  });

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) => PatientProfileModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    id: json["id"],
    chronicDiseases: json["chronic_diseases"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "id": id,
    "chronic_diseases": chronicDiseases,
  };
}

class User {
  final String? username;
  final String? email;
  final String? gender;
  final String? phoneNumber;
  final DateTime? birthDate;
  final String? image;

  User({
    this.username,
    this.email,
    this.gender,
    this.phoneNumber,
    this.birthDate,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    email: json["email"],
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "gender": gender,
    "phone_number": phoneNumber,
    "birth_date": birthDate?.toIso8601String(),
    "image": image,
  };
}
