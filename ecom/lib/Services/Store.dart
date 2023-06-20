import 'package:shared_preferences/shared_preferences.dart';

class Store{
  const Store._();

  static const String _tokenKey = "TOKEN";
  static const String _tokenRefreshKey = "REFRESH_TOKEN";

  static Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  static Future<void> setRefreshToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenRefreshKey, token);
  }

  static Future<String?> getToken() async{
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}