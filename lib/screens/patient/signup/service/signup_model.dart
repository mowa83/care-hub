class SignupModel {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String userType;
  final String gender;
  final String phoneNumber;
  final String birthDate;
  final String chronicDiseases;

  SignupModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.userType = 'Patient',
    required this.gender,
    required this.phoneNumber,
    required this.birthDate,
    required this.chronicDiseases,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'user_type': userType,
      'gender': gender,
      'phone_number': phoneNumber, 
      'birth_date': birthDate,
      'chronic_diseases': chronicDiseases,
    };
  }
}
