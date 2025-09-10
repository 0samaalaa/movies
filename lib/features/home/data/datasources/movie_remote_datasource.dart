import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieRemoteDatasource {
  Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(Uri.parse('https://yts.mx/api/v2/list_movies.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['movies'] as List;
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
