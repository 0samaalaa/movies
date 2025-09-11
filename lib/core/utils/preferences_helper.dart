import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String HasSeenOnboarding = 'hasSeenOnboarding';
  static const String LanguageCode = 'languageCode';

  final SharedPreferences prefs;

  PreferencesHelper(this.prefs);

  bool get hasSeenOnboarding => prefs.getBool(HasSeenOnboarding) ?? false;
  Future<void> setHasSeenOnboarding(bool value) async {
    await prefs.setBool(HasSeenOnboarding, value);
  }

  String get languageCode => prefs.getString(LanguageCode) ?? 'en';
  Future<void> setLanguageCode(String code) async {
    await prefs.setString(LanguageCode, code);
  }


}
