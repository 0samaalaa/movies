import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites_event.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/favorite_button.dart';
import '../widgets/info_badge.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_event.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(CheckIfFavorite(widget.movieId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieDetailsBloc()..add(FetchMovieDetailsEvent(widget.movieId)),
        ),
        BlocProvider.value(value: context.read<FavoritesBloc>()),
        BlocProvider.value(value: context.read<ProfileBloc>()),
      ],
      child: Scaffold(
        backgroundColor: MColors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(
              Directionality.of(context) == TextDirection.rtl ? MIcons.backr : MIcons.back,
              width: 18,
            ),

            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, state) {
                if (state is MovieDetailsLoaded) {
                  return FavoriteButton(details: state.details);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
          listener: (context, state) {
            if (state is MovieDetailsLoaded) {
              final details = state.details;
              context.read<ProfileBloc>().add(
                AddToHistoryEvent({
                  "id": details.id,
                  "title": details.title,
                  "posterPath": details.poster,
                }),
              );
            }
          },
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: MColors.yellow),
              );
            } else if (state is MovieDetailsLoaded) {
              final details = state.details;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 600,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(details.poster),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 420,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, MColors.black],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final messenger = ScaffoldMessenger.of(context);
                                  final trailerUrl = 'https://www.youtube.com/watch?v=${details.ytTrailerCode}';
                                  if (await canLaunchUrl(Uri.parse(trailerUrl))) {
                                    await launchUrl(Uri.parse(trailerUrl),
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    messenger.showSnackBar(
                                      const SnackBar(content: Text('Could not launch trailer')),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  child: Image.asset(MIcons.play),
                                ),
                              ),
                              const SizedBox(height: 130),
                              Text(
                                details.title,
                                style: const TextStyle(
                                  color: MColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${details.year}',
                                style: const TextStyle(
                                  color: MColors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MColors.red,
                            minimumSize: const Size(380, 58),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final url = details.url;
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              messenger.showSnackBar(
                                const SnackBar(content: Text('Cannot open link')),
                              );
                            }
                          },
                          child: Text(
                            l10n.watch,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: MColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(child: InfoBadge(iconPath: MIcons.heart, label: details.likeCount.toString())),
                          const SizedBox(width: 12),
                          Expanded(child: InfoBadge(iconPath: MIcons.time, label: "${details.runtime}")),
                          const SizedBox(width: 12),
                          Expanded(child: InfoBadge(iconPath: MIcons.star, label: "${details.rating}")),
                        ],
                      ),
                    ),
                    const SizedBox(height: 21),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.screenshots,
                        style: const TextStyle(
                          color: MColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    details.screenshots.isNotEmpty
                        ? Column(
                      children: details.screenshots.map((url) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(url, width: double.infinity, height: 120, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(height: 120, color: MColors.dgrey, alignment: Alignment.center,
                                child: const Text(
                                  'No screenshot available',
                                  style: TextStyle(color: MColors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        l10n.noScreenshots,
                        style: const TextStyle(color: MColors.grey, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.similar,
                        style: const TextStyle(
                          color: MColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    state.suggestions.isEmpty
                        ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        l10n.noSimilar,
                        style: const TextStyle(color: MColors.grey, fontSize: 16),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.suggestions.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, idx) {
                          final movie = state.suggestions[idx];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MovieDetailsScreen(movieId: movie.id),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: movie.coverImage.isNotEmpty
                                        ? Image.network(
                                      movie.coverImage,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          Container(color: MColors.dgrey),
                                    )
                                        : Container(
                                      color: MColors.dgrey,
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported, color: MColors.white, size: 40),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: MColors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star,
                                              color: MColors.yellow, size: 15),
                                          const SizedBox(width: 3),
                                          Text(
                                            "${movie.rating}",
                                            style: const TextStyle(
                                              color: MColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.summary,
                        style: const TextStyle(
                          color: MColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        details.descriptionFull,
                        style: const TextStyle(color: MColors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.cast,
                        style: const TextStyle(
                          color: MColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    details.cast.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Column(
                        children: details.cast.map((actor) {
                          return Card(
                            color: MColors.dgrey,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: actor.avatar != null && actor.avatar!.isNotEmpty
                                    ? Image.network(
                                  actor.avatar!,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  width: 48,
                                  height: 48,
                                  color: MColors.dgrey,
                                  child: const Icon(Icons.person, color: MColors.white, size: 60),
                                ),
                              ),
                              title: Text(
                                'Name: ${actor.name}',
                                style: const TextStyle(color: MColors.white, fontSize: 15),
                              ),
                              subtitle: Text(
                                'Character: ${actor.characterName}',
                                style: const TextStyle(color: MColors.white, fontSize: 15),
                              ),
                            ),
                          );

                        }).toList(),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        l10n.noCast,
                        style: const TextStyle(
                          color: MColors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.genres,
                        style: const TextStyle(
                          color: MColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: details.genres.isNotEmpty
                            ? details.genres
                            .map((genre) => Chip(
                          backgroundColor: MColors.dgrey,
                          label: Text(
                            genre,
                            style: const TextStyle(color: MColors.white),
                          ),
                        ))
                            .toList() : [Text(l10n.noGenres, style: const TextStyle(color: MColors.dgrey),
                        )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            } else if (state is MovieDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: MColors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}