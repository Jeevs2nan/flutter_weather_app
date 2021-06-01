import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreference {
  static Sharedpreference? _sharedpreference;

  static Sharedpreference? getInstance() {
    if (_sharedpreference != null) {
      return _sharedpreference;
    } else {
      _sharedpreference = Sharedpreference();
      return _sharedpreference;
    }
  }



  void addString(String key, String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(key, value);
  }

  void addInt(String key, int value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setInt(key, value);
  }

  void addBool(String key, bool value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(key, value);
  }

  void addDouble(String key, double value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setDouble(key, value);
  }

  void removeValues(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove(key);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(key) ?? "";
  }

  Future<int> getIntValue(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getInt(key) ?? 0;
  }

  Future<double> getDoubleValue(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getDouble(key) ?? 0.0;
  }

  Future<bool> getBoolValue(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool(key) ?? false;
  }

  Future<bool> checkWeatherTheKeyHasValueOrNot(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
