// our data
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:profile_challenge/components/rounded_button.component.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/views/change.view.dart';
import 'package:profile_challenge/views/register.view.dart';
import 'package:profile_challenge/widgets/info_card.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  final User user;

  ProfileView({Key? key, required this.user}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  widget.user.avatar != null ? widget.user.avatar! : ""),
            ),
            Text(
              widget.user.name != null ? widget.user.name! : "",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blueGrey[200],
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            InfoCard(
              text: widget.user.phone != null ? widget.user.phone! : "",
              icon: Icons.phone,
              onPressed: () async {},
            ),
            InfoCard(
              text: widget.user.cpf != null ? widget.user.cpf! : "",
              icon: Icons.dock,
              onPressed: () async {},
            ),
            InfoCard(
                text: widget.user.gender != null ? widget.user.gender! : "",
                icon: Icons.merge_type,
                onPressed: () async {}),
            InfoCard(
              text: widget.user.email != null ? widget.user.email! : "",
              icon: Icons.email,
              onPressed: () async {},
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterView(user: widget.user);
                    },
                  ),
                )
              },
              child: RoundedButton(
                text: "Editar",
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeView();
                    },
                  ),
                )
              },
              child: RoundedButton(
                color: Colors.black12,
                textColor: Colors.black,
                text: "Sair",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
