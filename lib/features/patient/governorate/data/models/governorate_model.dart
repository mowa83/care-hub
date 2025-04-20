import 'dart:convert';

GovernorateModel governorateModelFromJson(String str) => GovernorateModel.fromJson(json.decode(str));

String governorateModelToJson(GovernorateModel data) => json.encode(data.toJson());

class GovernorateModel {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Result>? results;

  GovernorateModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) => GovernorateModel(
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

  Result({
    this.id,
    this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
