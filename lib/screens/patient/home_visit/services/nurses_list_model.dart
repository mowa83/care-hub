import 'dart:convert';

NursesListModel nursesListModelFromJson(String str) => NursesListModel.fromJson(json.decode(str));

String nursesListModelToJson(NursesListModel data) => json.encode(data.toJson());

class NursesListModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  NursesListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory NursesListModel.fromJson(Map<String, dynamic> json) => NursesListModel(
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
  final String? user;
  final dynamic price;
  final int? id;
  final String? about;
  final String? image;
  final String? city;

  Result({
    this.user,
    this.price,
    this.id,
    this.about,
    this.image,
    this.city,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: json["user"],
    price: json["price"],
    id: json["id"],
    about: json["about"],
    image: json["image"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "price": price,
    "id": id,
    "about": about,
    "image": image,
    "city": city,
  };
}

