import 'package:shared_preferences/shared_preferences.dart';

class DBStore {
  static Future<bool> setData(String key, String data) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setString(key, data);
  }
}
