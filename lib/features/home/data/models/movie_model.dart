import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.backgroundImage,
    required super.posterImage,
    required super.rating,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"],
      backgroundImage: json["background_image"] ?? '',
      posterImage: json["medium_cover_image"] ?? '',
      rating: (json["rating"] is int) ? (json["rating"] as int).toDouble() : (json["rating"] ?? 0.0),
      genres: List<String>.from(json["genres"] ?? []),
    );
  }
}
