import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final sp = '';
  static SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
    } catch (err) {
      rethrow;
    }
  }

  static String getString(String key) {
    return _sharedPreferences.getString(key);
  }

  static Future<bool> putString(String key, String value) async {
    return _sharedPreferences.setString(key, value);
  }
}
