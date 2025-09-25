import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'back'**
  String get back;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Explore now'**
  String get exploreNow;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Find Your Next\nFavorite Movie Here'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Get access to a huge library of movies to suit all tastes. You will surely like it.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Discover Movies'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Explore All Genres'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.'**
  String get onboardingDesc3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Create Watchlists'**
  String get onboardingTitle4;

  /// No description provided for @onboardingDesc4.
  ///
  /// In en, this message translates to:
  /// **'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.'**
  String get onboardingDesc4;

  /// No description provided for @onboardingTitle5.
  ///
  /// In en, this message translates to:
  /// **'Rate, Review, and Learn'**
  String get onboardingTitle5;

  /// No description provided for @onboardingDesc5.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.'**
  String get onboardingDesc5;

  /// No description provided for @onboardingTitle6.
  ///
  /// In en, this message translates to:
  /// **'Start Watching Now'**
  String get onboardingTitle6;

  /// No description provided for @onboardingDesc6.
  ///
  /// In en, this message translates to:
  /// **''**
  String get onboardingDesc6;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forgetPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @Register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account ?'**
  String get dontHaveAccount;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get createOne;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginWithGoogle;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get alreadyHaveAccount;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @watch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watch;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @updateData.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get updateData;

  /// No description provided for @pickAvatar.
  ///
  /// In en, this message translates to:
  /// **'Pick Avatar'**
  String get pickAvatar;

  /// No description provided for Avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @watchList.
  ///
  /// In en, this message translates to:
  /// **'Watch List'**
  String get watchList;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @character.
  ///
  /// In en, this message translates to:
  /// **'Character'**
  String get character;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @sciFi.
  ///
  /// In en, this message translates to:
  /// **'Sci-Fi'**
  String get sciFi;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @fantasy.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get fantasy;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;


  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get drama;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get comedy;

  /// No description provided for @crime.
  /// In en, this message translates to:
  /// **'Crime'**
  String get crime;

  /// No description provided for @romance.
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;


  /// No description provided for @thriller.
  /// In en, this message translates to:
  /// **'Thriller'**
  String get thriller;

  /// No description provided for @mystery.
  /// In en, this message translates to:
  /// **'Mystery'**
  String get mystery;

  /// No description provided for @music.
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  String get areYouSureDelete;
  String get cancel;
  String get confirm;
  String get newPassword;
  String get oldPassword;
  String get screenshots;
  String get noScreenshots;
  String get similar;
  String get noCast;
  String get noGenres;
  String get noMoviesfound;
  String get all;
  String get documentary;
  String get family;
  String get filmNoir;
  String get gameShow;
  String get musical;
  String get news;
  String get realityTV;
  String get sport;
  String get talkShow;
  String get war;
  String get western;
  String get noSimilar;





}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
