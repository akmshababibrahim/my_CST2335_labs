import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository{
  static String loginName = "";
  static String password = "";
  static String firstname = "";
  static String lastname = "";
  static String emailaddress = "";
  static String mobilenumber = "";

  static final _pref = EncryptedSharedPreferences();

  static Future<void> loadData() async {
      firstname = await _pref.getString("firstName");
      lastname = await _pref.getString("lastName");
      mobilenumber = await _pref.getString("number");
      emailaddress = await _pref.getString("email");

  }
  // static Future<void> saveData() async {
  //   await _pref.setString("firstName", firstname.isEmpty ? "" : firstname);
  //   await _pref.setString("lastName", lastname.isEmpty ? "" : lastname);
  //   await _pref.setString("number", mobilenumber.isEmpty ? "" : mobilenumber);
  //   await _pref.setString("email", emailaddress.isEmpty ? "" : emailaddress);
  // }

  static Future<void> saveData() async {
    if (firstname.isEmpty) {
      await _pref.remove("firstName");
    } else {
      await _pref.setString("firstName", firstname);
    }

    if (lastname.isEmpty) {
      await _pref.remove("lastName");
    } else {
      await _pref.setString("lastName", lastname);
    }

    if (mobilenumber.isEmpty) {
      await _pref.remove("number");
    } else {
      await _pref.setString("number", mobilenumber);
    }

    if (emailaddress.isEmpty) {
      await _pref.remove("email");
    } else {
      await _pref.setString("email", emailaddress);
    }
  }


}