import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;
  ProfileLoaded(this.profileData);

  @override
  List<Object?> get props => [profileData];
}

class ProfileUpdated extends ProfileState {
  final String message;
  ProfileUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileDeleted extends ProfileState {
  final String message;
  ProfileDeleted(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordResetSuccess extends ProfileState {
  final String message;
  PasswordResetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordResetFailure extends ProfileState {
  final String message;
  PasswordResetFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class HistoryLoaded extends ProfileState {
  final List<Map<String, dynamic>> history;
  HistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class WatchlistLoaded extends ProfileState {
  final List<Map<String, dynamic>> watchlist;
  WatchlistLoaded(this.watchlist);

  @override
  List<Object?> get props => [watchlist];
}

class ProfileFullLoaded extends ProfileState {
  final Map<String, dynamic>? profileData;
  final List<Map<String, dynamic>> history;
  final List<Map<String, dynamic>> watchlist;

  ProfileFullLoaded({
    required this.profileData,
    required this.history,
    required this.watchlist,
  });

  @override
  List<Object?> get props => [profileData ?? {}, history, watchlist];
}

class ProfileListsLoading extends ProfileState {}
