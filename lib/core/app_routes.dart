import 'package:flutter/cupertino.dart';

import '../screens/authentication/forgot_password.dart';
import '../screens/authentication/login_screen.dart';
import '../screens/on_boarding/onboarding_view.dart';
import 'layout_screen.dart';


class APPROUTES{
  APPROUTES._();
  static const String onboardingScreen="onboardingScreens";
  static const String loginScreen="LoginScreen";
  static const String forgetPasswordScreen="ForgetPasswordScreen";
  static const String layoutScreen="LayoutScreen";







}

class ROUTES{
  ROUTES._();
  static Map<String, Widget Function(BuildContext)> routes ={
    APPROUTES.onboardingScreen :(_)=> OnboardingView(),
    APPROUTES.loginScreen :(_)=> LoginPage(),
    APPROUTES.forgetPasswordScreen: (_) => const ForgetPasswordScreen(),
    APPROUTES.layoutScreen :(_)=> const  LayoutScreen(),



  };
}