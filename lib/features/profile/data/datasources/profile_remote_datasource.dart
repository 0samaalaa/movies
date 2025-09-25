import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileRemoteDatasource {
  final String baseUrl = "https://route-movie-apis.vercel.app";

  Future<Map<String, dynamic>> getProfile(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body["data"];
    } else {
      throw Exception("Failed to load profile");
    }
  }

  Future<void> updateProfile(String token, String name, String phone, int avatarId) async {
    final res = await http.patch(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "avaterId": avatarId,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to update profile");
    }
  }

  Future<void> deleteAccount(String token) async {
    final res = await http.delete(
      Uri.parse("$baseUrl/profile"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to delete account");
    }
  }

  Future<List<Map<String, dynamic>>> getFavorites(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/favorites/all"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final list = body["data"] as List<dynamic>? ?? [];
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } else {
      throw Exception("Failed to load favorites");
    }
  }
}