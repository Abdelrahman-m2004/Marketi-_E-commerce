import 'package:shared_preferences/shared_preferences.dart';

class Splashlocaldata {
  Future<bool> getIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('IsFristTime') ?? true;
  }

  Future<bool> saveFristTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool('IsFristTime', value);
  }
}
