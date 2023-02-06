import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/utils/api.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  UserModel? user;

  Future<void> getUserProfile(String username) async {
    final url = '${Api.api}/users/${username}';
    log(url);

    try {
      final response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'token ${Api.token}'});
      log(response.body);

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      log(responseData['bio']);

      user = UserModel(
          username: responseData['login'],
          imageUrl: responseData['avatar_url'],
          followers: responseData['followers'],
          followings: responseData['following'],
          publicRepo: responseData['public_repos'],
          joiningDate: responseData['created_at'],
          bio: responseData['bio'],
          location: responseData['location'],
          email: responseData['email']);
      log(user!.publicRepo.toString());
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
