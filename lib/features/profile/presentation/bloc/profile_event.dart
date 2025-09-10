abstract class ProfileEvent {}

class ResetPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  ResetPasswordEvent({required this.oldPassword, required this.newPassword});
}

