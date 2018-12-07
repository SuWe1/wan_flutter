import 'package:shared_preferences/shared_preferences.dart';

const USER_NAME = 'user_name';
const USER_PASSWORD = 'user_password';
const LAST_SAVE_TIME = 'last_save_time';

class PreferenceUtils {
  static putStr(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static getStr(String key, Function callback) async {
    SharedPreferences.getInstance().then((prefs) {
      callback(prefs.getString(key));
    });
  }
}