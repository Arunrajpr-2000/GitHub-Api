import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:github_api/model/repo_model.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/utils/api.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  UserModel? user;

  static Future<List<UserModel>> getUserProfile(String? userName) async {
    final url = '${Api.api}/users/$userName';
    log(url);

    try {
      List<UserModel> usersList = [];

      final response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'token ${Api.token}'});
      // log(response.body);

      final responseData = json.decode(response.body);
      for (var user in responseData) {
        log(user['name'].toString());
        usersList.add(UserModel.fromJson(user));
      }
      return usersList;

      //log(responseData['bio']);

      // user = UserModel(
      //     username: responseData['login'],
      //     imageUrl: responseData['avatar_url'],
      //     followers: responseData['followers'],
      //     followings: responseData['following'],
      //     publicRepo: responseData['public_repos'],
      //     joiningDate: responseData['created_at'],
      //     bio: responseData['bio'],
      //     location: responseData['location'],
      //     email: responseData['email']);
      // log(user!.publicRepo.toString());
      // notifyListeners();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
