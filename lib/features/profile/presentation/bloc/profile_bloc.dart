import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/preferences_helper.dart';
import '../../../../core/utils/token_manager.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../favorites/domain/usecases/get_favorites.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  final PreferencesHelper prefs;
  final GetFavorites getFavoritesUseCase;

  ProfileBloc(this.repository, this.prefs, this.getFavoritesUseCase)
      : super(ProfileInitial()) {
    on<LoadProfileListsEvent>(_onLoadHistory);
    on<AddToHistoryEvent>(_onAddToHistory);
    on<ClearHistoryEvent>(_onClearHistory);
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<ResetPasswordEvent>(_onResetPassword);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoadHistory(
      LoadProfileListsEvent event, Emitter<ProfileState> emit) async {
    final history = prefs.getHistoryMovies().toList();
    emit(ProfileFullLoaded(
        profileData: state is ProfileFullLoaded
            ? (state as ProfileFullLoaded).profileData
            : null,
        history: history,
        watchlist: state is ProfileFullLoaded
            ? (state as ProfileFullLoaded).watchlist
            : []));
  }

  Future<void> _onAddToHistory(
      AddToHistoryEvent event, Emitter<ProfileState> emit) async {
    await prefs.addMovieToHistory(event.movie);
    add(LoadProfileListsEvent());
  }

  Future<void> _onClearHistory(
      ClearHistoryEvent event, Emitter<ProfileState> emit) async {
    await prefs.clearHistory();
    add(LoadProfileListsEvent());
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final data = await repository.getProfile();
      final favorites = await getFavoritesUseCase();
      final watchlist = favorites
          .map((movie) => {
        "movieId": movie.movieId,
        "title": movie.title,
        "posterPath": movie.posterImage,
        "rating": movie.rating,
        "year": movie.year,
      }).toList();
      final history = prefs.getHistoryMovies().reversed.toList();
      emit(ProfileFullLoaded(
          profileData: data, history: history, watchlist: watchlist));
    } catch (e) {
      emit(ProfileError("Failed to load profile: $e"));
    }
  }


  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await repository.updateProfile(event.name, event.phone, event.avatarId);
      emit(ProfileUpdated("Profile updated successfully"));
      add(LoadProfileEvent());
    } catch (e) {
      emit(ProfileError("Failed to update profile"));
    }
  }


  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await repository.deleteAccount();
      await prefs.clearAll();
      await TokenManager.clearToken();
      emit(ProfileDeleted("Account deleted successfully"));
    } catch (e) {
      emit(ProfileError("Failed to delete account"));
    }
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await repository.resetPassword(event.oldPassword, event.newPassword);
      emit(PasswordResetSuccess("Password reset successfully"));
    } catch (e) {
      emit(PasswordResetFailure("Failed to reset password"));
    }
  }

  Future<void> _onLogout(
      LogoutEvent event, Emitter<ProfileState> emit) async {
    await prefs.logout();
    await TokenManager.clearToken();
    emit(ProfileInitial());
  }


}
