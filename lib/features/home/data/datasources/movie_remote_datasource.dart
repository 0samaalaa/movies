import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieRemoteDatasource {
  Future<List<MovieModel>> fetchMovies({String? query, int page = 1}) async {
    final url = Uri.parse(
      'https://yts.mx/api/v2/list_movies.json?limit=50&page=$page${query != null && query.isNotEmpty ? '&query_term=$query' : ''}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['movies'] as List?;
      if (data == null) return [];
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
