import 'dart:io';

class DoctorNurseSignupModel {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String userType;
  final String gender;
  final String phoneNumber;
  final String birthDate;
  final File image;
  final File card;
  final String governorate;
  final String city;
  final String specialty;

  final String about;
  final String services;
  final String certificates;
  final int? price;
  final int? experienceYear;

  DoctorNurseSignupModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.userType,
    required this.gender,
    required this.phoneNumber,
    required this.birthDate,
    required this.image,
    required this.card,
    required this.governorate,
    required this.city,
    required this.specialty,
    this.about = '',
    this.services = '',
    this.certificates = '',
    this.price,
    this.experienceYear,
  });
}
