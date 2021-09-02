import 'dart:io';

import 'package:dio/dio.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';
import 'package:profile_challenge/models/user_to_login.dart';
import 'package:profile_challenge/services/api/auth_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final AuthGateway _authGateway = AuthGateway(Dio());

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userToLogin = UserToLogin(
          email: email,
          password: password,
          deviceName: Platform.operatingSystem);

      final response =
          await _authGateway.postUserToLogin(userToLogin: userToLogin);

      SharedPreferences prfs = await SharedPreferences.getInstance();
      prfs.setString("token", response.data!.token!);
      return response.data?.user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<User?> register(UserToCreateOrUpdate user) async {
    try {
      final response = await _authGateway.createUser(user: user);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
