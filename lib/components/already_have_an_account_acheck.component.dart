import 'package:flutter/material.dart';
import 'package:profile_challenge/resources/colors.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Já tem uma conta? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () => press(),
          child: Text(
            "Faça login",
            style: TextStyle(
              color: ColorsResources.COLOR_D95284,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
