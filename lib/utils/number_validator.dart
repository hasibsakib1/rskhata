bool numberValidator(String value) {
  Pattern pattern = r'^01\d{9}$';
  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}
