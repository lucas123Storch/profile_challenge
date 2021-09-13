import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';
import 'package:profile_challenge/resources/environment.dart';
import 'package:profile_challenge/services/api/gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGateway extends Gateway {
  UserGateway(httpClient) : super(httpClient: httpClient);

  Future<List<User>?> getUsers({required String token}) async {
    final url = '${environment.webAppUrl}/users';

    final response = await request(url, (payLoad) {
      return payLoad;
    }, token: token, method: HTTPMethod.get);

    if (response["data"] != null) {
      return List<User>.from(response["data"].map((i) => User.fromJson(i)));
    }
  }

  Future<User?> getUser({required String id, required String token}) async {
    final url = '${environment.webAppUrl}/users/$id';

    final response = await request(url, (payLoad) {
      return payLoad;
    }, token: token, method: HTTPMethod.get);

    if (response["data"] != null) {
      return User.fromJson(response["data"]);
    }
  }

  Future<User> updateUser(
      {required UserToCreateOrUpdate user, required String token}) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    token = prfs.getString("token")!;
    final url = '${environment.webAppUrl}/profile';
    return await request(url, (payLoad) {
      return User.fromJson(payLoad["data"]["user"]);
    }, data: user.toJson(), token: token, method: HTTPMethod.put);
  }

  Future<String> deleteUser({required String id, required String token}) async {
    final url = '${environment.webAppUrl}/users/$id';
    return await request(url, (payLoad) {
      return payLoad["message"];
    }, token: token, method: HTTPMethod.delete);
  }
}
