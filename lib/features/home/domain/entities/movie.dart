class Movie {
  final int id;
  final String title;
  final String backgroundImage;
  final String posterImage;
  final double rating;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.backgroundImage,
    required this.posterImage,
    required this.rating,
    required this.genres,
  });
}
