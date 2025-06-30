class AppointmentDoctorModel {
  int? id;
  int? doctor;
  String? date;
  String? time;
  int? patientId;
  String? patientName;
  String? phoneNumber;

  AppointmentDoctorModel({
    this.id,
    this.doctor,
    this.date,
    this.time,
    this.patientId,
    this.patientName,
    this.phoneNumber,
  });

  AppointmentDoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor = json['doctor'];
    date = json['date'];
    time = json['time'];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['doctor'] = doctor;
    data['date'] = date;
    data['time'] = time;
    data['patient_id'] = patientId;
    data['patient_name'] = patientName;
    data['phone_number'] = phoneNumber;
    return data;
  }
}