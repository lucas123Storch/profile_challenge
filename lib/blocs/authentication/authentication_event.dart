import 'package:equatable/equatable.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLogIn extends AuthenticationEvent {
  final String email;
  final String password;

  UserLogIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


class RegisterEvent extends AuthenticationEvent {
  final UserToCreateOrUpdate user;

  RegisterEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthenticationEvent {}

class AuthenticationFailed extends AuthenticationEvent {
  final String message;

  AuthenticationFailed({required this.message});

  @override
  List<Object> get props => [message];
}
