abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String phone;
  final int avatarId;

  UpdateProfileEvent({
    required this.name,
    required this.phone,
    required this.avatarId,
  });
}

class DeleteAccountEvent extends ProfileEvent {}

class ResetPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  ResetPasswordEvent({required this.oldPassword, required this.newPassword});
}

