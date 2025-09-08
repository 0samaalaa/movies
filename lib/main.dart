import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_bloc_observer.dart';
import 'core/resources/app_colors.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/utils/preferences_helper.dart';
import 'features/on_boarding/presentation/cubit/onboarding_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final preferencesHelper = PreferencesHelper(prefs);
  final hasSeenOnboarding = preferencesHelper.hasSeenOnboarding;
  Bloc.observer = AppBlocObserver();

  runApp(
    BlocProvider(
      create: (_) => OnboardingCubit(preferencesHelper),
      child: MoviesApp(
        hasSeenOnboarding: hasSeenOnboarding,
      ),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MoviesApp({
    Key? key,
    required this.hasSeenOnboarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: MColors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: MColors.yellow),
          titleTextStyle: TextStyle(color: MColors.yellow),
          centerTitle: true,
        ),
      ),
      initialRoute: hasSeenOnboarding
          ? Routes.loginScreen
          : Routes.onboardingScreen,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
