import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/resources/app_Images.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/app_icons.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/custom_text_filed.dart';
import '../../../../../main.dart';
import '../../../../core/utils/token_manager.dart';
import '../../../profile/data/datasources/profile_remote_datasource.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;


  void showAwesomeSnackBar(BuildContext context, String title, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthAuthenticated) {
            final prefs = await SharedPreferences.getInstance();
            await TokenManager.saveToken(state.token);
            await prefs.setString("token", state.token);
            await prefs.setBool('isLoggedIn', true);

            try {
              final remote = ProfileRemoteDatasource();
              final profileData = await remote.getProfile(state.token);
              final String userName = (profileData["name"] ?? "").toString();
              final int avatarId = profileData["avaterId"] ?? 0;
              final String phone = profileData["phone"] ?? "";
              await prefs.setString("userName", userName);
              await prefs.setInt("avatarId", avatarId);
              await prefs.setString("phone", phone);
            } catch (e) {
            }

            Navigator.pushReplacementNamed(context, Routes.layoutScreen);
            showAwesomeSnackBar(
              context,
              "Success",
              "Login successful!",
              ContentType.success,
            );
          } else if (state is AuthError) {
            showAwesomeSnackBar(context, "Error", state.message, ContentType.failure);
          }
        },

        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ZoomIn(
                      duration: const Duration(seconds: 2),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 20,
                        ),
                        child: Image.asset(
                          MImages.logo2,
                          width: 110,
                          height: 110,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFiled(
                      controller: _emailController,
                      hintText: l10n.email,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          MIcons.mail,
                          width: 18,
                          height: 18,
                          color: MColors.white,
                        ),
                      ),
                      validator: (val) => val == null || val.isEmpty ? l10n.email : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFiled(
                      controller: _passwordController,
                      hintText: l10n.password,
                      isPassword: true,
                      obscureText: !_isPasswordVisible,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          MIcons.lock,
                          width: 18,
                          height: 18,
                          color: MColors.white,
                        ),
                      ),
                          onToggleVisibility: () {
                          setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                          });  },
                      validator: (val) => val == null || val.isEmpty ? l10n.password : null,
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.resetPasswordScreen);
                        },
                        child: Text(
                          l10n.forgetPassword,
                          style: const TextStyle(
                            fontSize: 14,
                            color: MColors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MColors.yellow,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthBloc>().add(
                              LoginRequested(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        child: isLoading
                            ? const CircularProgressIndicator(color: MColors.black)
                            : Text(
                          l10n.login,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: MColors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.dontHaveAccount,
                          style: const TextStyle(color: MColors.white, fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.registerScreen);
                          },
                          child: Text(
                            l10n.createOne,
                            style: const TextStyle(
                              color: MColors.yellow,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: AnimatedToggleSwitch<String>.rolling(
                        current: Localizations.localeOf(context).languageCode,
                        values: const ["en", "ar"],
                        height: 43,
                        indicatorSize: const Size(43, 43),
                        spacing: 20,
                        onChanged: (newLang) {
                          final newLocale = Locale(newLang);
                          MoviesApp.of(context)?.setLocale(newLocale);
                        },
                        iconBuilder: (value, foreground) {
                          final flag = value == "en" ? MIcons.en : MIcons.arabic;
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: foreground ? Border.all(color: MColors.yellow, width: 4) : null,
                            ),
                            child: ClipOval(
                              child: Image.asset(flag, fit: BoxFit.cover),
                            ),
                          );
                        },
                        style: ToggleStyle(
                          backgroundColor: Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          borderColor: MColors.yellow,
                          indicatorColor: Colors.transparent,
                          indicatorBorder: Border.all(color: MColors.yellow, width: 4),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
