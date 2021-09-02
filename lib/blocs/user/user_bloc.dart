import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';
import 'package:profile_challenge/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;

  UserBloc(UserService userService)
      : _userService = userService,
        super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UpdateUserEvent) {
      yield* _mapUpdateUserToState(event);
    } else if (event is GetAllUserEvent) {
      yield* _mapGetAllUserToState(event);
    } else if (event is GetUserEvent) {
      yield* _mapGetUserToState(event);
    } else if (event is DeleteUserEvent) {
      yield* _mapDeleteUserToState(event);
    }
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUserEvent event) async* {
    try {
      final userUpdate = await _userService.update(event.user, event.token);

      if (userUpdate != null) {
        yield UserUpdated(user: userUpdate);
      }
    } catch (e) {
      yield UserFailedState(message: e.toString());
    }
  }

  Stream<UserState> _mapGetAllUserToState(GetAllUserEvent event) async* {
    try {
      final users = await _userService.getAll(event.token);

      if (users != null) {
        yield UsersLoaded(users: users);
      }
    } catch (e) {
      yield UserFailedState(message: e.toString());
    }
  }

  Stream<UserState> _mapGetUserToState(GetUserEvent event) async* {
    try {
      final user = await _userService.getUser(event.id, event.token);

      if (user != null) {
        yield UserLoaded(user: user);
      }
    } catch (e) {
      yield UserFailedState(message: e.toString());
    }
  }

  Stream<UserState> _mapDeleteUserToState(DeleteUserEvent event) async* {
    try {
      final isDeleted = await _userService.deleteUser(event.id, event.token);

      if (isDeleted != null) {
        yield UserDeleted(success: isDeleted);
      }
    } catch (e) {
      yield UserFailedState(message: e.toString());
    }
  }
}
