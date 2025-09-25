import 'package:flutter/material.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../home/domain/entities/movie.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final double screenWidth;

  const MovieGrid({
    super.key,
    required this.movies,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = screenWidth > 600 ? 4 : 2;
    final childAspectRatio = screenWidth > 600 ? 0.7 : 0.65;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, idx) {
        final movie = movies[idx];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.movieDetailsScreen,
            arguments: {'movieId': movie.id},
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              movie.poster,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: MColors.dgrey),
            ),
          ),
        );
      },
    );
  }
}
