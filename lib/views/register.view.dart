import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profile_challenge/components/already_have_an_account_acheck.component.dart';
import 'package:profile_challenge/components/rounded_button.component.dart';
import 'package:profile_challenge/components/rounded_input_field.component.dart';
import 'package:profile_challenge/components/rounded_password_field.component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.09),
              SvgPicture.asset(
                "assets/icons/image2.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Nome",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "CPF",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Email",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Telefone",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Estado Civil",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Sexo",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              GestureDetector(
                child: RoundedButton(
                  text: "Cadastrar",
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top2.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom2.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
