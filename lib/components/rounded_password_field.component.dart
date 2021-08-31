import 'package:flutter/material.dart';
import 'package:profile_challenge/components/text_field_container.component.dart';
import 'package:profile_challenge/resources/colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: ColorsResources.COLOR_D95284,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: ColorsResources.COLOR_D95284,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: ColorsResources.COLOR_D95284,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}