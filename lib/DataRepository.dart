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
  static Future<void> saveData() async {
    // EncryptedSharedPreferences stores strings, so null -> empty or delete
    await _pref.setString("firstName", firstname ?? '');
    await _pref.setString("lastName", lastname ?? '');
    await _pref.setString("number",    mobilenumber?? '');
    await _pref.setString("email",    emailaddress ?? '');
  }

  Future<void> clear() async {
    await _pref.clear();
  }
}