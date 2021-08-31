import 'package:flutter/material.dart';
import 'package:profile_challenge/resources/colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    this.color = ColorsResources.COLOR_D95284,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Container(
          color: color,
          child: Container(
            height: size.height * 0.06,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
