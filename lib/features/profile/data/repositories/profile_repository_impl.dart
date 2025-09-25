import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/preferences_helper.dart';
import '../../../../core/utils/token_manager.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final PreferencesHelper prefsHelper;

  ProfileRepositoryImpl(this.remoteDatasource, this.prefsHelper);

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Please Login First");
    }

    final data = await remoteDatasource.getProfile(token);

    return {
      "name": data["name"] ?? "Unknown",
      "phone": data["phone"] ?? "",
      "avaterId": data["avaterId"] ?? 1,
      ...data,
    };
  }

  @override
  Future<void> updateProfile(String name, String phone, int avatarId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("Please Login First");

    await remoteDatasource.updateProfile(token, name, phone, avatarId);
  }

  @override
  Future<String> resetPassword(String oldPassword, String newPassword) async {
    final token = await TokenManager.getToken();
    if (token == null) throw Exception("Please Login First");

    final url = Uri.parse("https://route-movie-apis.vercel.app/auth/reset-password");
    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data["message"] ?? "Password reset successfully";
    } else {
      throw Exception("Failed to reset password: ${response.body}");
    }
  }

  @override
  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("Token not found");

    await remoteDatasource.deleteAccount(token);
    await prefs.clear();
  }

  @override
  Future<List<Map<String, dynamic>>> getWatchlistFromApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("Please Login First");

    return await remoteDatasource.getFavorites(token);
  }


  @override
  List<Map<String, dynamic>> getHistoryMovies() => prefsHelper.getHistoryMovies();

  @override
  Future<void> addMovieToHistory(Map<String, dynamic> movie) => prefsHelper.addMovieToHistory(movie);

  @override
  Future<void> clearHistory() => prefsHelper.clearHistory();

  @override
  List<Map<String, dynamic>> getWatchlistMovies() => prefsHelper.getWatchlistMovies();

  @override
  Future<void> addMovieToWatchlist(Map<String, dynamic> movie) => prefsHelper.addMovieToWatchlist(movie);

  @override
  Future<void> removeMovieFromWatchlist(int movieId) => prefsHelper.removeMovieFromWatchlist(movieId);

  @override
  Future<void> clearWatchlist() => prefsHelper.clearWatchlist();
}
