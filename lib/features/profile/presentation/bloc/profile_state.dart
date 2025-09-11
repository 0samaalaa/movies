abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;

  ProfileLoaded(this.profileData);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class PasswordResetSuccess extends ProfileState {
  final String message;
  PasswordResetSuccess(this.message);
}

class PasswordResetFailure extends ProfileState {
  final String error;
  PasswordResetFailure(this.error);
}


class ProfileUpdated extends ProfileState {
  final String message;

  ProfileUpdated(this.message);
}

class ProfileDeleted extends ProfileState {
  final String message;

  ProfileDeleted(this.message);
}
