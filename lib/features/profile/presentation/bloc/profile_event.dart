import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

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

  @override
  List<Object?> get props => [name, phone, avatarId];
}

class DeleteAccountEvent extends ProfileEvent {}

class ResetPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  ResetPasswordEvent({required this.oldPassword, required this.newPassword});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class LoadProfileWithLocalEvent extends ProfileEvent {}
class LoadProfileListsEvent extends ProfileEvent {}

class AddToHistoryEvent extends ProfileEvent {
  final Map<String, dynamic> movie;
  AddToHistoryEvent(this.movie);
  @override
  List<Object?> get props => [movie];
}

class ClearHistoryEvent extends ProfileEvent {}

class AddToWatchlistEvent extends ProfileEvent {
  final Map<String, dynamic> movie;
  AddToWatchlistEvent(this.movie);
  @override
  List<Object?> get props => [movie];
}

class RemoveFromWatchlistEvent extends ProfileEvent {
  final int movieId;
  RemoveFromWatchlistEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class LogoutEvent extends ProfileEvent {}
