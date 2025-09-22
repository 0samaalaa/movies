import 'package:flutter/material.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/features/home/presentation/pages/home_screen.dart';
import 'package:movies/features/layout/presentation/pages/layout_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/pages/reset_password.dart';
import '../../features/browse/presentation/pages/browse_screen.dart';
import '../../features/movie_details/presentation/pages/movie_details.dart';
import '../../features/on_boarding/presentation/pages/onboarding_view.dart';
import '../../features/profile/presentation/pages/edit_profile.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingView());

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Routes.layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.browseScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BrowseScreen(
            initialGenre: args?['genre'],
          ),
        );

      case Routes.movieDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && args.containsKey('movieId')) {
          final int movieId = args['movieId'];
          return MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movieId: movieId),
          );
        }
        return _undefinedRoute();

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(child: Text("No Route Found")),
      ),
    );
  }
}
