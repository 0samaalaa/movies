import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const String _baseUrl = "https://route-movie-apis.vercel.app/";

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("${_baseUrl}auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      throw jsonData["message"] ?? "Login failed";
    }
  }

  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    final url = Uri.parse("${_baseUrl}auth/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avatarId,
      }),
    );

    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonData["message"] ?? "Registered successfully";
    } else {
      throw Exception(jsonData["message"] ?? "Registration failed");
    }
  }
}
