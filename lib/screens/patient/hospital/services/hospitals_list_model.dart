import 'dart:convert';

List<HospitalsListModel> hospitalsListModelFromJson(String str) => List<HospitalsListModel>.from(json.decode(str).map((x) => HospitalsListModel.fromJson(x)));

String hospitalsListModelToJson(List<HospitalsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HospitalsListModel {
  final int? id;
  final String? city;
  final String? name;
  final String? address;
  final String? image;

  HospitalsListModel({
    this.id,
    this.city,
    this.name,
    this.address,
    this.image,
  });

  factory HospitalsListModel.fromJson(Map<String, dynamic> json) => HospitalsListModel(
    id: json["id"],
    city: json["city"],
    name: json["name"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "name": name,
    "address": address,
    "image": image,
  };
}
