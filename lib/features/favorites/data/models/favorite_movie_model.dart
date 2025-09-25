import '../../domain/entities/favorite_movie_entity.dart';

class FavoriteMovieModel extends FavoriteMovie {
  const FavoriteMovieModel({
    required super.movieId,
    required super.title,
    required super.rating,
    required super.posterImage,
    required super.year,
  });

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) {
    return FavoriteMovieModel(
      movieId: json['movieId'] as String,
      title: json['title'] as String,
      rating: (json['rating'] as num).toDouble(),
      posterImage: json['posterImage'] as String,
      year: json['year'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "movieId": movieId,
      "title": title,
      "rating": rating,
      "posterImage": posterImage,
      "year": year,
    };
  }
}
