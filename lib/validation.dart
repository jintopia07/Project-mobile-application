// @dart=2.9
class CustomValidation {
  static bool isValidPersonCardID(String cardID) {
    if (cardID.length != 13) {
      return false;
    }
    return true;
  }

  static bool isPassportValid(String passportID) {
    if (passportID.length != 6) {
      return false;
    }
    return true;
  }
}
