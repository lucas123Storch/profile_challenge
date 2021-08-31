import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profile_challenge/components/rounded_button.component.dart';
import 'package:profile_challenge/views/login.view.dart';

class ChangeView extends StatelessWidget {
  const ChangeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/image1.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginView();
                    }),
                  );
                },
                child: RoundedButton(
                  text: "Entrar",
                ),
              ),
              RoundedButton(
                text: "Fazer Cadastro",
                color: Colors.black12,
                textColor: Colors.black,
                // press: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) {
                //         return LoginView();
                //       },
                //     ),
                //   );
                // },
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
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top2.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom2.png",
              width: size.width * 0.2,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
