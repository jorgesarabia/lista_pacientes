class Validators {
  static final RegExp _emailRegExp = RegExp(
    // r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
    // r'^[a-zA-Z0-9.a-zA-Z0-9]+@[a-zA-Z0-9]+(.[a-zA-Z]+){1,}$',
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }


  // static final RegExp _passwordRegExp = RegExp(
    // r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  // );

  static isValidPassword(String password) {
    // return _passwordRegExp.hasMatch(password);
    return password.length > 6;
  }

}
