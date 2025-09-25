class Movie {
  final int id;
  final String title;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.rating,
  });
}
