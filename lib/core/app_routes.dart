import 'package:flutter/cupertino.dart';

import '../screens/authentication/login_screen.dart';
import '../screens/on_boarding/onboarding_view.dart';


class APPROUTES{
  APPROUTES._();
  static const String onboardingScreen="onboardingScreens";
  static const String loginScreen="LoginScreen";






}

class ROUTES{
  ROUTES._();
  static Map<String, Widget Function(BuildContext)> routes ={
    APPROUTES.onboardingScreen :(_)=> OnboardingView(),
    APPROUTES.loginScreen :(_)=> LoginPage(),

  };
}