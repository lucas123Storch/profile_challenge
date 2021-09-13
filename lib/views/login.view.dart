import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profile_challenge/blocs/blocs.dart';
import 'package:profile_challenge/components/already_have_an_account_acheck.component.dart';
import 'package:profile_challenge/components/rounded_button.component.dart';
import 'package:profile_challenge/components/rounded_input_field.component.dart';
import 'package:profile_challenge/components/rounded_password_field.component.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/views/profile.view.dart';
import 'package:profile_challenge/views/register.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  var maskNull = new MaskTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    Size size = MediaQuery.of(context).size;

    _onLoginButtonPressed() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        _authBloc.add(UserLogIn(
            email: _emailController.text, password: _passwordController.text));
      } else {
        _authBloc.add(
          AuthenticationFailed(
            message: _emailController.text.isEmpty
                ? 'Digite seu email'
                : 'Digite sua senha',
          ),
        );
      }
    }

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
      if (state is AuthenticationFailure) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginView();
            },
          ),
        );
      } else if (state is AuthenticationAuthenticated) {
        // _showSucccess("Usuário autenticado: ${state.user.name}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfileView(user: state.user);
            },
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                SvgPicture.asset(
                  "assets/icons/image2.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: _emailController,
                  mask: maskNull,
                  hintText: "Email",
                  onChanged: (value) {
                    _emailController.text = value;
                    _emailController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _emailController.text.length),
                    );
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    _passwordController.text = value;
                    _passwordController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _passwordController.text.length),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () => _onLoginButtonPressed(),
                  child: RoundedButton(
                    text: "LOGIN",
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterView(user: User());
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  void _showSucccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
