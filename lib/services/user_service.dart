import 'package:dio/dio.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';
import 'package:profile_challenge/services/api/user_gateway.dart';

class UserService {
  final UserGateway _userGateway = UserGateway(Dio());


  Future<User?> update(UserToCreateOrUpdate user, String token) async {
    try {
      final response = await _userGateway.updateUser(user: user, token: token);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<User>?> getAll(String token) async {
    try {
      final response = await _userGateway.getUsers(token: token);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<User?> getUser(String id, String token) async {
    try {
      final response = await _userGateway.getUser(id: id, token: token);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool?> deleteUser(String id, String token) async {
    try {
      await _userGateway.deleteUser(id: id, token: token);
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
