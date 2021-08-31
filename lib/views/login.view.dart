import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profile_challenge/components/already_have_an_account_acheck.component.dart';
import 'package:profile_challenge/components/rounded_button.component.dart';
import 'package:profile_challenge/components/rounded_input_field.component.dart';
import 'package:profile_challenge/components/rounded_password_field.component.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
   
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/image2.svg",
                height: size.height * 0.35,
              ),
    
              SizedBox(height: size.height * 0.03),
    
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
              ),
    
              RoundedPasswordField(
                onChanged: (value) {},
              ),
    
              RoundedButton(
                text: "LOGIN",
                press: () {},
              ),
    
              SizedBox(height: size.height * 0.03),
    
              AlreadyHaveAnAccountCheck(
                press: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return SignUpScreen();
                  //     },
                  //   ),
                  // );
                },
              ),
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