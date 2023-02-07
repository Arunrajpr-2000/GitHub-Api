import 'dart:convert';
import 'dart:developer';

import 'package:github_api/model/user_model.dart';
import 'package:github_api/utils/api.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  UserModel? user;

  static Future<List<UserModel>> getUserList(String username) async {
    final url = '${Api.api}/search/users?q=$username';

    final uri = '${Api.api}/users/$username'; //////////////////////////////

    log(url);

    try {
      List<UserModel> usersList = [];

      final response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'token ${Api.token}'});
      final responseData = json.decode(response.body) as Map;

      for (var user in responseData["items"]) {
        usersList.add(UserModel.fromJson(user));
      }

      return usersList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<UserModel> getuserProfile(String username) async {
    final url = '${Api.api}/users/$username';
    log(url);

    try {
      final response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'token ${Api.token}'});

      final responseData = json.decode(response.body);
      final user = UserModel.fromJson(responseData);

      return user;
    } catch (e) {
      print(e);
      return Future.error('error');
    }
  }
}
