import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<ResetPasswordEvent>(_onResetPassword);
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

}
