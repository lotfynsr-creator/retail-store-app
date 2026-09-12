class AppValidation {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter Your Email";
    }

    if (!value.contains("@")) {
      return "Please Enter a Valid Email";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }
}
