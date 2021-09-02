part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class UpdateUserEvent extends UserEvent {
  final UserToCreateOrUpdate user;
  final String token;

  UpdateUserEvent({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}

class GetAllUserEvent extends UserEvent {
  final String token;

  GetAllUserEvent({required this.token});

  @override
  List<Object> get props => [token];
}

class GetUserEvent extends UserEvent {
  final String id;
  final String token;

  GetUserEvent({required this.id, required this.token});

  @override
  List<Object> get props => [id, token];
}

class DeleteUserEvent extends UserEvent {
  final String id;
  final String token;

  DeleteUserEvent({required this.id, required this.token});

  @override
  List<Object> get props => [id, token];
}
