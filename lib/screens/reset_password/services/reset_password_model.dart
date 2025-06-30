class ResetPasswordRequest {
  final String password;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'password': password,
        'confirm_password': confirmPassword,
      };
}
