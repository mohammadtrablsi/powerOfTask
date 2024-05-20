String? vaildator(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "you can't leave it empty";
  }

  if (type == "name") {
    final nameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!nameRegExp.hasMatch(val)) {
      return "please enter your correct name";
    }
  }

  if (type == "email") {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(val)) {
      return "please enter your correct email";
    }
  }

  if (type == "phone") {
    final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegExp.hasMatch(val)) {
      return "please enter your correct phone number";
    }
  }

  if (val.length < min) {
    return "value can't be less than $min";
  }
  if (val.length > max) {
    return "value can't be larger than $max";
  }

  return null;
}

String? validationRepeatPassword(String val, String password) {
  if (val.isEmpty) {
    return "you can't leave it empty";
  }

  if (val != password) {
    return "this is not the same password";
  }

  return null;
}
