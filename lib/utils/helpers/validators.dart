class Validators {
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile number can not be empty";
    } else if (value.length <= 5) {
      return "Please enter a valid Mobile number";
    } else {
      return null;
    }
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return "OTP field can not be empty";
    } else if (value.length != 6) {
      return "Invalid OTP Number";
    } else {
      return null;
    }
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password should not be empty";
    } else {
      if (!RegExp(r'^.{8,}$').hasMatch(value)) {
        return "Password should be minimum 8 characters";
      } else if (!RegExp('.*[a-z].*').hasMatch(value)) {
        return "Should have at least one lower character";
      } else if (!RegExp('.*[A-Z].*').hasMatch(value)) {
        return "Should have at least one upper character";
      } else if (!RegExp(".*[0-9].*").hasMatch(value)) {
        return "Should contain at least one number";
      } else if (!RegExp(".*[!@#&*~\$%_].*").hasMatch(value)) {
        return "Should contain at least one special character";
      } else {
        return null;
      }
    }
  }

  static String? validateConfirmPassword(
      String? newPassword, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm password should not be empty";
    } else {
      if (newPassword == null || newPassword.isEmpty) {
        return null;
      } else if (confirmPassword != newPassword) {
        return "Password doesn't match";
      } else {
        return null;
      }
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password should not be empty";
    } else if (value.length <= 4) {
      return "Please enter a valid password";
    } else {
      return null;
    }
  }

  static String? validateCommonMessage(String? value, String title) {
    if (value == null || value.isEmpty) {
      return "$title must be entered";
    } else {
      return null;
    }
  }

  static String? validatePriorityMessage(String? value) {
    if (value == null || value.isEmpty) {
      return "Comment must be entered";
    } else if (value.length <= 10) {
      return "Please enter at least 10 characters";
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Full name must be entered";
    } else if (value.length <= 3) {
      return "Please enter a valid full name";
    } else {
      return null;
    }
  }
}
