import 'package:equatable/equatable.dart';

class FavoriteMovie extends Equatable {
  final String movieId;
  final String title;
  final double rating;
  final String posterImage;
  final String year;

  const FavoriteMovie({
    required this.movieId,
    required this.title,
    required this.rating,
    required this.posterImage,
    required this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'name': title,
      'rating': rating,
      'imageURL': posterImage,
      'year': year,
    };
  }

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      movieId: json['movieId'] as String,
      title: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      posterImage: json['imageURL'] as String,
      year: json['year'] as String,
    );
  }

  @override
  List<Object?> get props => [movieId, title, rating, posterImage, year];
}

class FavoriteMovieModel extends FavoriteMovie {
  const FavoriteMovieModel({
    required String movieId,
    required String title,
    required double rating,
    required String posterImage,
    required String year,
  }) : super(
    movieId: movieId,
    title: title,
    rating: rating,
    posterImage: posterImage,
    year: year,
  );

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) {
    return FavoriteMovieModel(
      movieId: json['movieId'] as String,
      title: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      posterImage: json['imageURL'] as String,
      year: json['year'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'name': title,
      'rating': rating,
      'imageURL': posterImage,
      'year': year,
    };
  }
}
