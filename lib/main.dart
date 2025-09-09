import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_bloc_observer.dart';
import 'core/resources/app_colors.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/utils/preferences_helper.dart';
import 'features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final preferencesHelper = PreferencesHelper(prefs);
  final hasSeenOnboarding = preferencesHelper.hasSeenOnboarding;
  final savedLang = preferencesHelper.languageCode;
  Bloc.observer = AppBlocObserver();

  runApp(
    BlocProvider(
      create: (_) => OnboardingCubit(preferencesHelper),
      child: MoviesApp(
        hasSeenOnboarding: hasSeenOnboarding,
        preferencesHelper: preferencesHelper,
        initialLocale: Locale(savedLang),
      ),
    ),
  );
}

class MoviesApp extends StatefulWidget {
  final bool hasSeenOnboarding;
  final PreferencesHelper preferencesHelper;
  final Locale initialLocale;

  const MoviesApp({
    Key? key,
    required this.hasSeenOnboarding,
    required this.preferencesHelper,
    required this.initialLocale,
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: ThemeData(
        scaffoldBackgroundColor: MColors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: MColors.yellow),
          titleTextStyle: TextStyle(color: MColors.yellow),
          centerTitle: true,
        ),
      ),
      initialRoute:
      widget.hasSeenOnboarding ? Routes.loginScreen : Routes.onboardingScreen,
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
