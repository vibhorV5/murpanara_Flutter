class UserMethods {
  static String checkNumField(num digit) {
    if (digit == 0) {
      return '';
    } else {
      return digit.toString();
    }
  }

  static String checkUserName(String name) {
    if (name == '') {
      return 'Member';
    } else {
      return name;
    }
  }

  static String getCurrentDateTime(DateTime orderTime) {
    return orderTime.toString();
  }
}
