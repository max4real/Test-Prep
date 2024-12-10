import 'package:shared_preferences/shared_preferences.dart';

class SpService {
  static Future<bool> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool spFirstTime = prefs.getBool('spFirstTime') ?? true;

    return spFirstTime;
  }

  static Future<void> saveState({required bool isFirstTime}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spFirstTime', isFirstTime);
  }
}
