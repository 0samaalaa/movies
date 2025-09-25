import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../movie_details/presentation/pages/movie_details.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/routes/routes.dart';
import 'widgets/header.dart';
import 'widgets/tab_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  int selectedTab = 0;
  Map<String, dynamic> _localProfileData = {"name": "", "avaterId": 0, "phone": ""};

  @override
  void initState() {
    super.initState();
    _loadProfileFromPrefs();
    final bloc = context.read<ProfileBloc>();
    bloc.add(LoadProfileListsEvent());
    bloc.add(LoadProfileEvent());
  }

  Future<void> _loadProfileFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _localProfileData = {
        "name": prefs.getString("userName") ?? "",
        "avaterId": prefs.getInt("avatarId") ?? 0,
        "phone": prefs.getString("phone") ?? "",
      };
    });
  }

  void _updateLocalProfile(String name, int avatarId, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", name);
    await prefs.setInt("avatarId", avatarId);
    await prefs.setString("phone", phone);
    setState(() {
      _localProfileData = {"name": name, "avaterId": avatarId, "phone": phone};
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    super.build(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileInitial) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (_) => false);
        }
      },
      child: Scaffold(
        backgroundColor: MColors.black,
        body: Column(
          children: [
            Container(
              color: MColors.dgrey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          List<Map<String, dynamic>> history = [];
                          List<Map<String, dynamic>> watchlist = [];
                          if (state is ProfileFullLoaded) {
                            history = state.history;
                            watchlist = state.watchlist;
                          }

                          return ProfileHeader(
                            userName: _localProfileData["name"],
                            avatarId: _localProfileData["avaterId"],
                            watchlistCount: watchlist.length,
                            historyCount: history.length,
                            onEditProfile: () async {
                              if (_localProfileData["name"].isEmpty && _localProfileData["phone"].isEmpty) return;

                              final result = await Navigator.pushNamed(
                                context,
                                Routes.editProfileScreen,
                                arguments: {
                                  "name": _localProfileData["name"],
                                  "avaterId": _localProfileData["avaterId"],
                                  "phone": _localProfileData["phone"],
                                },
                              );

                              if (result != null && result is Map<String, dynamic>) {
                                _updateLocalProfile(
                                  result["name"] ?? _localProfileData["name"],
                                  result["avaterId"] ?? _localProfileData["avaterId"],
                                  result["phone"] ?? _localProfileData["phone"],
                                );
                              }
                            },
                            onLogout: () {
                              context.read<ProfileBloc>().add(LogoutEvent());
                            },
                          );
                        },
                      ),
                    ),
                    ProfileTabs(
                      selectedTab: selectedTab,
                      onTabSelected: (index) => setState(() => selectedTab = index),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileListsLoading) {
                    return const Center(child: CircularProgressIndicator(color: MColors.yellow));
                  } else if (state is ProfileFullLoaded) {
                    final list = (selectedTab == 0 ? state.watchlist : state.history).reversed.toList();
                    if (list.isEmpty) {
                      return Center(
                        child: Text(
                          selectedTab == 0 ? l10n.watchList : l10n.history,
                          style: const TextStyle(color: MColors.white, fontSize: 16),
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final movie = list[index];
                        final movieId = int.tryParse((movie["movieId"] ?? movie["id"]).toString()) ?? 0;
                        final imageUrl = movie["imageURL"] ?? movie["posterPath"] ?? "";
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId: movieId)),
                            );
                            context.read<ProfileBloc>().add(LoadProfileEvent());
                            context.read<ProfileBloc>().add(LoadProfileListsEvent());
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: MColors.dgrey,
                                child: const Icon(Icons.movie, color: MColors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
