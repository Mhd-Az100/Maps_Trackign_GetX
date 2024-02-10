/// Validator class

class Validator {
  static String? validatePhone(String? phone) {
    if (phone!.isEmpty) {
      return "Phone Number cannot be empty!";
    } else if (phone.length < 9) {
      return "Phone Number is too short!";
    }
    return null;
  }

  static String? validateText(String? value) {
    if (value!.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (email!.isEmpty) {
      return "Email cannot be empty!";
    } else if (!regex.hasMatch(email)) {
      return "Enter Valid Email!";
    }
    return null;
  }
}
