class AvailableSlots {
  int? id;
  String? date;
  String? time;
  String? doctorName;
  String? specialty;

  AvailableSlots(
      {this.id, this.date, this.time, this.doctorName, this.specialty});

  AvailableSlots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    doctorName = json['doctor_name'];
    specialty = json['specialty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    data['doctor_name'] = doctorName;
    data['specialty'] = specialty;
    return data;
  }
}

class AddSlots {
  String? message;
  int? addedSlots;

  AddSlots({this.message, this.addedSlots});

  AddSlots.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    addedSlots = json['added_slots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['added_slots'] = addedSlots;
    return data;
  }
}

class UpdateSlot {
  String? message;
  Data? data;

  UpdateSlot({this.message, this.data});

  UpdateSlot.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? date;
  String? time;
  String? doctorName;
  String? specialty;

  Data({this.id, this.date, this.time, this.doctorName, this.specialty});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    doctorName = json['doctor_name'];
    specialty = json['specialty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    data['doctor_name'] = doctorName;
    data['specialty'] = specialty;
    return data;
  }
}