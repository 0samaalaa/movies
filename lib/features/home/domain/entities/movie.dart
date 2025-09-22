class Movie {
  final int id;
  final String title;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final double rating;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.rating,
    required this.genres,
  });



  String get poster {
    if ((largeCoverImage ?? '').isNotEmpty) return largeCoverImage!;
    if ((mediumCoverImage ?? '').isNotEmpty) return mediumCoverImage!;
    if ((smallCoverImage ?? '').isNotEmpty) return smallCoverImage!;
    return 'https://via.placeholder.com/500x750';
  }
}
