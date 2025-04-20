import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Result>? results;

  CityModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
  final Governorate? governorate;
  final String? name;

  Result({
    this.id,
    this.governorate,
    this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    governorate: json["governorate"] == null ? null : Governorate.fromJson(json["governorate"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "governorate": governorate?.toJson(),
    "name": name,
  };
}

class Governorate {
  final int? id;
  final String? name;

  Governorate({
    this.id,
    this.name,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}