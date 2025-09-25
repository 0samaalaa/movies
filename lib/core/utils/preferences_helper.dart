import 'dart:convert';
import 'package:movies/core/utils/token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String HasSeenOnboarding = 'hasSeenOnboarding';
  static const String LanguageCode = 'languageCode';
  static const String HistoryMovies = 'historyMovies';
  static const String WatchlistMovies = 'watchlistMovies';

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
  List<Map<String, dynamic>> getHistoryMovies() {
    final list = prefs.getStringList(HistoryMovies) ?? [];
    return list.map((e) => json.decode(e) as Map<String, dynamic>).toList();
  }

  Future<void> addMovieToHistory(Map<String, dynamic> movie) async {
    final current = getHistoryMovies();
    current.removeWhere((m) => m["id"].toString() == movie["id"].toString());
    current.insert(0, movie);
    if (current.length > 20) {
      current.removeLast();
    }
    final encoded = current.map((e) => json.encode(e)).toList();
    await prefs.setStringList(HistoryMovies, encoded);
  }

  Future<void> clearHistory() async {
    await prefs.remove(HistoryMovies);
  }
  List<Map<String, dynamic>> getWatchlistMovies() {
    final list = prefs.getStringList(WatchlistMovies) ?? [];
    return list.map((e) => json.decode(e) as Map<String, dynamic>).toList();
  }

  Future<void> addMovieToWatchlist(Map<String, dynamic> movie) async {
    final current = getWatchlistMovies();
    current.removeWhere((m) => m["id"].toString() == movie["id"].toString());
    current.insert(0, movie);
    final encoded = current.map((e) => json.encode(e)).toList();
    await prefs.setStringList(WatchlistMovies, encoded);
  }

  Future<void> removeMovieFromWatchlist(int movieId) async {
    final current = getWatchlistMovies();
    current.removeWhere((m) => m["id"].toString() == movieId.toString());
    final encoded = current.map((e) => json.encode(e)).toList();
    await prefs.setStringList(WatchlistMovies, encoded);
  }

  Future<void> clearWatchlist() async {
    await prefs.remove(WatchlistMovies);
  }

  Future<void> logout() async {
    await clearHistory();
    await clearWatchlist();
    await prefs.remove('isLoggedIn');
    await TokenManager.clearToken();
  }

  Future<void> clearAll() async {
    await prefs.clear();
    await TokenManager.clearToken();
  }





}

