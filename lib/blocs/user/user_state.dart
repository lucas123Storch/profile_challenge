part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFailedState extends UserState {
  final String message;

  UserFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserUpdated extends UserState {
  final User user;

  UserUpdated({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDeleted extends UserState {
  final bool success;

  UserDeleted({required this.success});

  @override
  List<Object> get props => [success];
}
