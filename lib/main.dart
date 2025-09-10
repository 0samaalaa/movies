import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_bloc_observer.dart';
import 'core/localization/app_localizations.dart';
import 'core/resources/app_colors.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/utils/preferences_helper.dart';
import 'features/home/data/datasources/movie_remote_datasource.dart';
import 'features/home/data/repositories/movie_repository_impl.dart';
import 'features/home/domain/usecases/get_movies.dart';
import 'features/home/presentation/bloc/movie_bloc.dart';
import 'features/home/presentation/bloc/movie_event.dart';
import 'features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/presentation/bloc/profile_event.dart';


final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final preferencesHelper = PreferencesHelper(prefs);

  final hasSeenOnboarding = preferencesHelper.hasSeenOnboarding;
  final savedLang = preferencesHelper.languageCode;

  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OnboardingCubit(preferencesHelper),
        ),
        BlocProvider(
          create: (_) => MovieBloc(
            GetMovies(
              MovieRepositoryImpl(MovieRemoteDatasource()),
            ),
          )..add(LoadMoviesEvent()),
        ),
      ],
      child: MoviesApp(
        hasSeenOnboarding: hasSeenOnboarding,
        preferencesHelper: preferencesHelper,
        initialLocale: Locale(savedLang),
        isLoggedIn: isLoggedIn,
      ),
    ),
  );
}

class MoviesApp extends StatefulWidget {
  final bool hasSeenOnboarding;
  final PreferencesHelper preferencesHelper;
  final Locale initialLocale;
  final bool isLoggedIn;

  const MoviesApp({
    Key? key,
    required this.hasSeenOnboarding,
    required this.preferencesHelper,
    required this.initialLocale,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  State<MoviesApp> createState() => _MoviesAppState();

  static _MoviesAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MoviesAppState>();
}

class _MoviesAppState extends State<MoviesApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
    widget.preferencesHelper.setLanguageCode(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final String initialRoute;
    if (!widget.hasSeenOnboarding) {
      initialRoute = Routes.onboardingScreen;
    } else if (widget.isLoggedIn) {
      initialRoute = Routes.layoutScreen;
    } else {
      initialRoute = Routes.loginScreen;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: ThemeData(
        scaffoldBackgroundColor: MColors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: MColors.yellow),
          titleTextStyle: TextStyle(color: MColors.yellow),
          centerTitle: true,
        ),
      ),
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
    );
  }
}
