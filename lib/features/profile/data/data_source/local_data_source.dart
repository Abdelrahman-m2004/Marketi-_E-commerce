import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<bool> isDarkMode();
  Future<void> cacheTheme(bool isDark);
}

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const _themeKey = 'is_dark_mode';

  LocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> isDarkMode() async {
    return _sharedPreferences.getBool(_themeKey) ?? false; // الافتراضي Light
  }

  @override
  Future<void> cacheTheme(bool isDark) async {
    await _sharedPreferences.setBool(_themeKey, isDark);
  }
}
