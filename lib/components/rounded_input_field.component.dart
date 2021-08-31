import 'package:flutter/material.dart';
import 'package:profile_challenge/components/text_field_container.component.dart';
import 'package:profile_challenge/resources/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(

      child: TextField(

        onChanged: onChanged,
        cursorColor: ColorsResources.COLOR_D95284,
        decoration: InputDecoration(

          icon: Icon(
            icon,
            color: ColorsResources.COLOR_D95284,
          ),
          hintText: hintText,
          border: InputBorder.none,

        ),
      ),

    );
  }
}