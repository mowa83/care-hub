import 'dart:convert';

SpecialtyModel specialtyModelFromJson(String str) => SpecialtyModel.fromJson(json.decode(str));

String specialtyModelToJson(SpecialtyModel data) => json.encode(data.toJson());

class SpecialtyModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  SpecialtyModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) => SpecialtyModel(
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
  final String? name;
  final String? icon;

  Result({
    this.id,
    this.name,
    this.icon,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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