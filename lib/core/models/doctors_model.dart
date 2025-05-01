import 'dart:convert';

DoctorsModel doctorsModelFromJson(String str) => DoctorsModel.fromJson(json.decode(str));

String doctorsModelToJson(DoctorsModel data) => json.encode(data.toJson());

class DoctorsModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  DoctorsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) => DoctorsModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  final int? id;
  final User? user;
  final int? price;
  final Specialty? specialty;
  final City? city;
  final int? offer;
  final String? about;

  Result({
    this.id,
    this.user,
    this.price,
    this.specialty,
    this.city,
    this.offer,
    this.about,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    price: json["price"],
    specialty: json["specialty"] == null ? null : Specialty.fromJson(json["specialty"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    offer: json["offer"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "price": price,
    "specialty": specialty?.toJson(),
    "city": city?.toJson(),
    "offer": offer,
    "about": about,
  };
}

class City {
  final int? id;
  final String? name;
  final int? governorate;

  City({
    this.id,
    this.name,
    this.governorate,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    governorate: json["governorate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "governorate": governorate,
  };
}

class Specialty {
  final int? id;
  final String? name;
  final String? icon;

  Specialty({
    this.id,
    this.name,
    this.icon,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
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
