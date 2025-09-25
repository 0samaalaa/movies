import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const _key = 'authToken';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_key);
    return token;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
