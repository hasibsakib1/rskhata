import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static Future<SharedPreferences> getSharedPref () async{
    final pref = await SharedPreferences.getInstance();
    return pref;
  }

  static Future<void> setString(String key, String value) async{
    final pref = await getSharedPref();
    pref.setString(key, value);
  }

  static Future<String?> getString(String key) async{
    final pref = await getSharedPref();
    return pref.getString(key);
  }

}