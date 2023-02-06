import 'dart:convert';
import 'dart:developer';

import 'package:github_api/model/repo_model.dart';
import 'package:github_api/utils/api.dart';
import 'package:http/http.dart' as http;

class RepoProvider {
  List<RepoModel>? user;

  Future<void> getRepo(String username) async {
    final url = '${Api.api}/users/${username}/repos';
    log(url);

    try {
      final response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'token ${Api.token}'});
      //log(response.body);

      final responseData = json.decode(response.body);

      user = RepoModel(
        reponame: responseData['name'],
        starcount: responseData['stargazers_count'],
        forkscount: responseData['forks_count'],
      ) as List<RepoModel>;

      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
