import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_response_login.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';
import 'package:profile_challenge/models/user_to_login.dart';
import 'package:profile_challenge/resources/environment.dart';
import 'package:profile_challenge/services/api/gateway.dart';

class AuthGateway extends Gateway {
  AuthGateway(httpClient) : super(httpClient: httpClient);

  Future<UserToResponseLogin> postUserToLogin(
      {required UserToLogin userToLogin}) async {
    final url = '${environment.webAppUrl}/login';
    return await request(url, (payLoad) {
      return UserToResponseLogin.fromJson(payLoad);
    }, data: userToLogin.toJson(), method: HTTPMethod.post);
  }

   Future<User> createUser(
      {required UserToCreateOrUpdate user}) async {
    final url = '${environment.webAppUrl}/register';
    return await request(url, (payLoad) {
      return User.fromJson(payLoad["data"]);
    }, data: user.toJson(), method: HTTPMethod.post);
  }
}
