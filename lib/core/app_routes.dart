import 'package:flutter/cupertino.dart';

import '../screens/authentication/forgot_password.dart';
import '../screens/authentication/login_screen.dart';
import '../screens/authentication/register_screen.dart';
import '../screens/on_boarding/onboarding_view.dart';
import 'layout_screen.dart';
import 'package:movies/screens/profile_screen/profile_screen.dart';
import 'package:movies/screens/profile_screen/edit_profile.dart';
import 'package:movies/screens/profile_screen/update_data.dart';



class APPROUTES{
  APPROUTES._();
  static const String onboardingScreen="onboardingScreens";
  static const String loginScreen="LoginScreen";
  static const String registerScreen="RegisterScreen";
  static const String forgetPasswordScreen="ForgetPasswordScreen";
  static const String layoutScreen="LayoutScreen";
  static const String profileScreen="ProfileScreen";
  static const String editProfileScreen="EditProfileScreen";
  static const String updateProfileScreen="UpdateProfileScreen";







}

class ROUTES{
  ROUTES._();
  static Map<String, Widget Function(BuildContext)> routes ={
    APPROUTES.onboardingScreen :(_)=> OnboardingView(),
    APPROUTES.loginScreen :(_)=> LoginPage(),
    APPROUTES.registerScreen: (_) => const RegisterScreen(),
    APPROUTES.forgetPasswordScreen: (_) => const ForgetPasswordScreen(),
    APPROUTES.layoutScreen :(_)=> const  LayoutScreen(),
    APPROUTES.profileScreen: (_) => const ProfileScreen(),
    APPROUTES.editProfileScreen: (_) => const EditProfileScreen(),
    APPROUTES.updateProfileScreen: (_) => const UpdateProfileScreen(),



  };
}