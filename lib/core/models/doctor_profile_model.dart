import 'dart:convert';

DoctorProfileModel doctorProfileModelFromJson(String str) => DoctorProfileModel.fromJson(json.decode(str));

String doctorProfileModelToJson(DoctorProfileModel data) => json.encode(data.toJson());

class DoctorProfileModel {
  final User? user;
  final int? id;
  final int? price;
  final int? experienceYear;
  final String? about;
  final String? certificates;
  final int? offer;
  final dynamic services;

  DoctorProfileModel({
    this.user,
    this.id,
    this.price,
    this.experienceYear,
    this.about,
    this.certificates,
    this.offer,
    this.services,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) => DoctorProfileModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    id: json["id"],
    price: json["price"],
    experienceYear: json["experience_year"],
    about: json["about"],
    certificates: json["certificates"],
    offer: json["offer"],
    services: json["services"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "id": id,
    "price": price,
    "experience_year": experienceYear,
    "about": about,
    "certificates": certificates,
    "offer": offer,
    "services": services,
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
