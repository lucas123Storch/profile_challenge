import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';
import '../../services/services.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    } else if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    } else if (event is UserLogIn) {
      yield* _mapUserLogInToState(event);
    } else if (event is AuthenticationFailed) {
      yield AuthenticationFailure(message: event.message);
    } else if (event is RegisterEvent) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<AuthenticationState> _mapUserLogInToState(UserLogIn event) async* {
    try {
      final user = await _authenticationService.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        yield AuthenticationAuthenticated(user: user);
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapRegisterToState(RegisterEvent event) async* {
    try {
      yield AuthenticationLoading();
      final user = await _authenticationService.register(event.user);
      if (user != null) {
        yield AuthenticationAuthenticated(user: user);
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    // await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
