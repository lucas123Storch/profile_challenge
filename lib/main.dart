import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_challenge/blocs/blocs.dart';
import 'package:profile_challenge/resources/colors.dart';
import 'package:profile_challenge/services/authentication_service.dart';
import 'package:profile_challenge/services/user_service.dart';
import 'package:profile_challenge/views/change.view.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/authentication/authentication_event.dart';

void main() => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationService>(
            create: (context) => AuthenticationService(),
          ),
          RepositoryProvider<UserService>(
            create: (context) => UserService(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) {
                final authService =
                    RepositoryProvider.of<AuthenticationService>(context);
                return AuthenticationBloc(authService)..add(AppLoaded());
              },
            ),
            BlocProvider<UserBloc>(
              create: (context) {
                final userService = RepositoryProvider.of<UserService>(context);
                return UserBloc(userService);
              },
            ),
          ],
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: ColorsResources.COLOR_D95284,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ChangeView(),
    );
  }
}
