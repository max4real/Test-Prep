import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceService {
  static Future<bool> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? spFirstTime = prefs.getBool('spFirstTime');

    if (spFirstTime != null) {
      return spFirstTime;
    } else {
      return true;
    }
  }

  static Future<void> saveState({required bool isFirstTime}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spFirstTime', isFirstTime);
  }
}
