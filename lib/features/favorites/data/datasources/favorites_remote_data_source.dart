import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/favorite_movie_entity.dart';

class FavoritesRemoteSource {
  final Dio dio;
  final String baseUrl = "https://route-movie-apis.vercel.app";

  FavoritesRemoteSource(this.dio);

  Future<void> addFavorite({required FavoriteMovie movie}) async {
    final token = await _getToken();
    try {
      await dio.post(
        "$baseUrl/favorites/add",
        data: movie.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      throw Exception("Failed to add favorite: $e");
    }
  }

  Future<List<FavoriteMovie>> getFavorites() async {
    final token = await _getToken();
    try {
      final response = await dio.get(
        "$baseUrl/favorites/all",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      final data = response.data["data"] as List<dynamic>;
      return data.map((json) => FavoriteMovie.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load favorites: $e");
    }
  }

  Future<void> removeFavorite(String movieId) async {
    final token = await _getToken();
    try {
      await dio.delete(
        "$baseUrl/favorites/remove/$movieId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      throw Exception("Failed to remove favorite: $e");
    }
  }

  Future<bool> isFavorite(String movieId) async {
    final token = await _getToken();
    try {
      final response = await dio.get(
        "$baseUrl/favorites/is-favorite/$movieId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return response.data["data"] as bool;
    } catch (e) {
      throw Exception("Failed to check favorite: $e");
    }
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("Please login first");
    return token;
  }
}
