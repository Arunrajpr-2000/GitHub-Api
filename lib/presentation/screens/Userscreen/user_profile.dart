import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_api/core/const.dart';
import 'package:github_api/model/repo_model.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/providers/repo_provider.dart';
import 'package:github_api/providers/user_providers.dart';

class ProfileScreen extends StatefulWidget {
  UserModel userprofile;
  List<RepoModel> repoList;
  //String username;

  ProfileScreen({
    Key? key,
    required this.userprofile,
    required this.repoList,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider userprovider = UserProvider();
  RepoProvider repoProvider = RepoProvider();

  RepoModel? repoModel;
  List<RepoModel> searchlist = [];
  // List<RepoModel>? gitRepoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //RepoProvider.getRepo(widget.userprofile.username!);
    searchlist = widget.repoList;
  }

  searchFun(String repoName) {
    setState(() {
      searchlist = widget.repoList
          .where((element) =>
              element.reponame!.toLowerCase().contains(repoName.toLowerCase()))
          .toList();
    });
    log(searchlist.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Searcher'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.network(widget.userprofile.imageUrl!)),
              k40width,
              Column(
                children: [
                  Text(widget.userprofile.username!),
                  Text(widget.userprofile.email ?? 'null'),
                  Text(widget.userprofile.location ?? 'Null'),
                  Text(widget.userprofile.joiningDate ?? 'null'),
                  Text('Followers ${widget.userprofile.followers ?? 'null'}'),
                  Text('Following ${widget.userprofile.followings ?? 'null'}')
                ],
              ),
            ],
          ),
          k20height,
          Text(widget.userprofile.bio ?? 'No Bio'),
          k20height,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                onChanged: (value) {
                  searchFun(value);
                },
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Search for users',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          k20height,
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: searchlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchlist[index].reponame.toString()),
                    trailing: Column(
                      children: [
                        k10height,
                        Text(searchlist[index].forkscount.toString()),
                        Text(searchlist[index].starcount.toString())
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
