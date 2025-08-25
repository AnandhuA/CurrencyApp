class Validators {
  static String? requiredField(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  //-----Email validation-----
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }
    return null;
  }

  //-----Password validation-----
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < minLength) {
      return "Password must be at least $minLength characters";
    }
    return null;
  }

  //-----Amount validation-----
  static String? amount(String? value) {
    if (value == null || value.isEmpty) {
      return "Amount is required";
    }
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return "Enter a valid amount";
    }
    return null;
  }

  //-----Name validation-----
  static String? name(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return "Enter a valid $fieldName";
    }
    return null;
  }

  //-----Phone number validation-----
  static String? phone(String? value, {int minLength = 8, int maxLength = 15}) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value)) {
      return "Phone number must contain only digits";
    }
    if (value.length < minLength || value.length > maxLength) {
      return "Phone number must be between $minLength and $maxLength digits";
    }
    return null;
  }
}
