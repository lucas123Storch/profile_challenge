import 'package:flutter/material.dart';
import 'package:profile_challenge/resources/colors.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: ColorsResources.COLOR_D95284,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: ColorsResources.COLOR_D95284,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
