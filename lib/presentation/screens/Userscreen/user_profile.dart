import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_api/core/const.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/providers/repo_provider.dart';
import 'package:github_api/providers/user_providers.dart';

class ProfileScreen extends StatefulWidget {
  UserModel userprofile;
  String username;

  ProfileScreen({Key? key, required this.userprofile, required this.username})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider provider = UserProvider();
  RepoProvider repoProvider = RepoProvider();
// @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repoProvider.getRepo(widget.username);
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
                  Text(widget.userprofile.joiningDate!),
                  Text('Followers ${widget.userprofile.followers!}'),
                  Text('Following ${widget.userprofile.followings!}')
                ],
              ),
            ],
          ),
          k20height,
          Text(widget.userprofile.bio ?? 'Null'),
          k20height,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: TextFormField(
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  log(repoProvider.user![index].reponame.toString());
                  return ListTile(
                    title: Text(repoProvider.user![index].reponame.toString()),
                    trailing: Column(
                      children: [k10height, Text('2 Forks'), Text('5 Stars')],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
