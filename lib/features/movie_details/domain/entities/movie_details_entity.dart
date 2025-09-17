class MovieDetails {
  final int id;
  final String title;
  final String descriptionFull;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> genres;
  final List<Cast> cast;
  final int year;
  final int likeCount;
  final int runtime;
  final double rating;
  final List<String> screenshots;
  final String ytTrailerCode;
  final String url;

  MovieDetails({
    required this.id,
    required this.title,
    required this.descriptionFull,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.genres,
    required this.cast,
    required this.year,
    required this.likeCount,
    required this.runtime,
    required this.rating,
    required this.screenshots,
    required this.ytTrailerCode,
    required this.url,
  });

  String get poster {
    if (largeCoverImage.isNotEmpty) return largeCoverImage;
    if (mediumCoverImage.isNotEmpty) return mediumCoverImage;
    if (smallCoverImage.isNotEmpty) return smallCoverImage;
    return 'https://via.placeholder.com/500x750';
  }

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    var castJson = json['cast'] as List? ?? [];
    List<Cast> castList = castJson.map((e) => Cast.fromJson(e)).toList();

    var genreList = List<String>.from(json['genres'] ?? []);

    List<String> screenshots = [];
    for (int i = 1; i <= 5; i++) {
      final key = 'large_screenshot_image$i';
      if (json[key] != null && json[key].toString().isNotEmpty) {
        screenshots.add(json[key]);
      }
    }

    return MovieDetails(
      id: json['id'] ?? 0,
      title: json['title'] ?? "Untitled",
      descriptionFull: json['description_full'] ?? "",
      smallCoverImage: json['small_cover_image'] ?? "",
      mediumCoverImage: json['medium_cover_image'] ?? "",
      largeCoverImage: json['large_cover_image'] ?? "",
      genres: genreList,
      cast: castList,
      year: json['year'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      runtime: json['runtime'] ?? 0,
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
      screenshots: screenshots,
      ytTrailerCode: json['yt_trailer_code'] ?? "",
      url: json['url'] ?? "",
    );
  }
}

class Cast {
  final String name;
  final String characterName;
  final String? avatar;

  Cast({
    required this.name,
    required this.characterName,
    this.avatar,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] ?? "Unknown",
      characterName: json['character_name'] ?? "N/A",
      avatar: json['url_small_image'],
    );
  }
}


class MovieSuggestion {
  final int id;
  final String title;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final double rating;

  MovieSuggestion({
    required this.id,
    required this.title,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.rating,
  });

  factory MovieSuggestion.fromJson(Map<String, dynamic> json) {
    return MovieSuggestion(
      id: json['id'] ?? 0,
      title: json['title'] ?? "Untitled",
      smallCoverImage: json['small_cover_image'] ?? "",
      mediumCoverImage: json['medium_cover_image'] ?? "",
      largeCoverImage: json['large_cover_image'] ?? "",
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
    );
  }

  String get coverImage {
    if (mediumCoverImage.isNotEmpty) return mediumCoverImage;
    if (largeCoverImage.isNotEmpty) return largeCoverImage;
    if (smallCoverImage.isNotEmpty) return smallCoverImage;
    return 'https://via.placeholder.com/100x140';
  }
}




