import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_routes.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: MColors.black,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: MColors.yellow),
              titleTextStyle: TextStyle(color:MColors.yellow),
              centerTitle: true)),
      debugShowCheckedModeBanner: false,
      routes: ROUTES.routes,
      initialRoute: APPROUTES.onboardingScreen,
    );
  }
}
