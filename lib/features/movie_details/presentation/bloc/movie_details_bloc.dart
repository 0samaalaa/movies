import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_details_entity.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<FetchMovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoading());
      try {
        final details = await fetchMovieDetails(event.movieId);
        List<String> finalScreenshots = details.screenshots;
        if (finalScreenshots.isEmpty && details.url.isNotEmpty) {
          finalScreenshots = await fetchScreenshotsFromPage(details.url);
        }

        String fullDesc = details.descriptionFull;
        if ((fullDesc.isEmpty || fullDesc.trim() == "") && details.url.isNotEmpty) {
          fullDesc = await fetchFullDescription(details.url);
        }

        final updatedDetails = MovieDetails(
          id: details.id,
          title: details.title,
          descriptionFull: fullDesc.isNotEmpty ? fullDesc : details.descriptionFull,
          smallCoverImage: details.smallCoverImage,
          mediumCoverImage: details.mediumCoverImage,
          largeCoverImage: details.largeCoverImage,
          genres: details.genres,
          cast: details.cast,
          year: details.year,
          likeCount: details.likeCount,
          runtime: details.runtime,
          rating: details.rating,
          screenshots: finalScreenshots,
          ytTrailerCode: details.ytTrailerCode,
          url: details.url,
        );

        final suggestions = await fetchMovieSuggestions(event.movieId);
        emit(MovieDetailsLoaded(updatedDetails, suggestions));
      } catch (e) {
        emit(MovieDetailsError(e.toString()));
      }
    });
  }

  Future<MovieDetails> fetchMovieDetails(int id) async {
    final response = await http.get(
      Uri.parse(
          'https://yts.mx/api/v2/movie_details.json?movie_id=$id&with_cast=true'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movieData = jsonData['data']['movie'];
      return MovieDetails.fromJson(movieData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<String>> fetchScreenshotsFromPage(String movieUrl) async {
    try {
      final response = await http.get(Uri.parse(movieUrl));
      if (response.statusCode != 200) return [];

      final document = parser.parse(response.body);
      final elements = document.querySelectorAll('img');
      final screenshots = elements.map((e) => e.attributes['src'] ?? e.attributes['data-src'] ?? '')
          .where((src) => src.toLowerCase().contains('screenshot'))
          .map((src) => src.startsWith('http') ? src : 'https:$src')
          .toList();

      screenshots.sort((a, b) {
        final regex = RegExp(r'screenshot[_-]?(\d)');
        final numA = regex.firstMatch(a) != null ? int.parse(regex.firstMatch(a)!.group(1)!) : 0;
        final numB = regex.firstMatch(b) != null ? int.parse(regex.firstMatch(b)!.group(1)!) : 0;
        return numA.compareTo(numB);
      });

      return screenshots;
    } catch (e) {
      return [];
    }
  }



  Future<List<MovieSuggestion>> fetchMovieSuggestions(int id) async {
    final response = await http.get(
      Uri.parse('https://yts.mx/api/v2/movie_suggestions.json?movie_id=$id'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movies = jsonData['data']['movies'] as List;
      return movies.map((e) => MovieSuggestion.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movie suggestions');
    }
  }

  Future<String> fetchFullDescription(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return "";

      final document = parser.parse(response.body);
      final element = document.querySelector('#synopsis p');
      return element?.text.trim() ?? "";
    } catch (e) {
      return "";
    }
  }


}

