import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final data = await repository.getProfile();
      emit(ProfileLoaded(data));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await repository.updateProfile(
        event.name,
        event.phone,
        event.avatarId,
      );
      emit(ProfileUpdated("Profile updated successfully"));

      final data = await repository.getProfile();
      emit(ProfileLoaded(data));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final message = await repository.resetPassword(
        event.oldPassword,
        event.newPassword,
      );
      emit(PasswordResetSuccess(message));
    } catch (e) {
      emit(PasswordResetFailure(e.toString()));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await repository.deleteAccount();
      emit(ProfileDeleted("Account deleted successfully"));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
