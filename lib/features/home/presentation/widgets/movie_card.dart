import 'package:flutter/material.dart';
import '../../../../core/resources/app_colors.dart';
import '../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isSelected;

  const MovieCard({
    super.key,
    required this.movie,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = isSelected ? 210 : 145;
    final double cardHeight = isSelected ? 310 : 230;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(
        horizontal: isSelected ? 10 : 22,
        vertical: isSelected ? 15 : 38,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: isSelected ? 18 : 3,
        borderRadius: BorderRadius.circular(24),
        shadowColor: MColors.yellow.withOpacity(0.18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: isSelected ? 1 : 0.55,
                duration: const Duration(milliseconds: 200),
                child: Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: MColors.dgrey),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: MColors.black.withOpacity(0.80),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: MColors.yellow, size: 15),
                      const SizedBox(width: 4),
                      Text(
                        "${movie.rating}",
                        style: const TextStyle(
                          color: MColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
