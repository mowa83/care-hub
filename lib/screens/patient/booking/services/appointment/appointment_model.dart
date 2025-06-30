class AppointmentModel {
  int? id;
  int? patientId;
  String? date;
  String? time;
  DoctorInfo? doctor;

  AppointmentModel({
    this.id,
    this.patientId,
    this.date,
    this.time,
    this.doctor,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id']; 
    date = json['date'];
    time = json['time'];
    doctor = json['doctor'] != null ? DoctorInfo.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (patientId != null) {
      data['patient_id'] = patientId;
    }
    data['date'] = date;
    data['time'] = time;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    return data;
  }
}

class DoctorInfo {
  int? id;
  String? doctorName;
  String? specialty;
  String? image;

  DoctorInfo({
    this.id,
    this.doctorName,
    this.specialty,
    this.image,
  });

  DoctorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['doctor_id']; 
    doctorName = json['doctor_name'];
    specialty = json['specialty'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_name'] = doctorName;
    data['specialty'] = specialty;
    data['image'] = image;
    return data;
  }
}