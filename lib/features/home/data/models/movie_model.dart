import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.smallCoverImage,
    required super.mediumCoverImage,
    required super.largeCoverImage,
    required super.rating,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"],
      smallCoverImage: json["small_cover_image"] ?? '',
      mediumCoverImage: json["medium_cover_image"] ?? '',
      largeCoverImage: json["large_cover_image"] ?? '',
      rating: (json["rating"] is int)
          ? (json["rating"] as int).toDouble()
          : (json["rating"] ?? 0.0),
      genres: List<String>.from(json["genres"] ?? []),
    );
  }
}
