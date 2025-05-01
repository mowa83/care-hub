import 'dart:convert';

List<HospitalModel> hospitalModelFromJson(String str) => List<HospitalModel>.from(json.decode(str).map((x) => HospitalModel.fromJson(x)));

String hospitalModelToJson(List<HospitalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HospitalModel {
  final int? id;
  final String? name;
  final String? openingTime;
  final String? closingTime;
  final Hospital? hospital;

  HospitalModel({
    this.id,
    this.name,
    this.openingTime,
    this.closingTime,
    this.hospital,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
    id: json["id"],
    name: json["name"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    hospital: json["hospital"] == null ? null : Hospital.fromJson(json["hospital"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "hospital": hospital?.toJson(),
  };
}

class Hospital {
  final String? name;
  final String? address;
  final dynamic image;

  Hospital({
    this.name,
    this.address,
    this.image,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    name: json["name"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "image": image,
  };
}
