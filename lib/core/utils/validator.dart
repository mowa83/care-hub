class Validator {

  static String? fullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Full Name!';
    } else if (value.length < 4) {
      return 'Invalid Full Name!';
    }
    return null;
  }
    static String? date (String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Birth Of Date';
    } 
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Phone!';
    } else if (!value.startsWith('01')) {
      return 'Invalid Phone!';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Email!';
    } else if (!value.contains('@') || !value.contains('.com')) {
      return 'Invalid Email!';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Password!';
    } else if (value.length < 8) {
      return 'Invalid Password length!';
    }
    return null;
  }
}