class AvailableSlotModel {
  int? id;
  String? date;
  String? time;
  String? doctorName;
  String? specialty;

  AvailableSlotModel({
    this.id,
    this.date,
    this.time,
    this.doctorName,
    this.specialty,
  });

  AvailableSlotModel.fromJson(Map<String, dynamic> json) {
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

class BookAppointmentModel {
  int? id;
  int? doctor;
  String? doctorName;
  String? date;
  String? time;

  BookAppointmentModel(
      {this.id, this.doctor, this.doctorName, this.date, this.time});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor = json['doctor'];
    doctorName = json['doctor_name'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor'] = doctor;
    data['doctor_name'] = doctorName;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}