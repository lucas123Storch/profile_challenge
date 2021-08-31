import 'package:flutter/material.dart';
import 'package:profile_challenge/resources/colors.dart';
import 'package:profile_challenge/views/change.view.dart';
import 'package:profile_challenge/views/login.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: ColorsResources.COLOR_D95284,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ChangeView(),
    );
  }
}