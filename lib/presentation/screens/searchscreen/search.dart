import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_api/core/const.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/presentation/screens/Userscreen/user_profile.dart';
import 'package:github_api/presentation/screens/splash.dart';
import 'package:github_api/providers/repo_provider.dart';
import 'package:github_api/providers/user_providers.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.userlist}) : super(key: key);

  final List<UserModel> userlist;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UserProvider provider = UserProvider();
  // String UserName = 'Arunrajpr-2000';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchuserlist = widget.userlist;
  }

  TextEditingController controller = TextEditingController();
  //provider.getUserProfile('');
  // getuser(String username) {
  //   provider.getUserProfile(username);
  // }

  List<UserModel>? searchuserlist;

  searchFun(String userName) {
    setState(() {
      searchuserlist = widget.userlist
          .where((element) =>
              element.username!.toLowerCase().contains(userName.toLowerCase()))
          .toList();
    });
    log(searchuserlist.toString());
  }

  @override
  Widget build(BuildContext context) {
    log(widget.userlist.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Searcher'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 70,
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
          Expanded(
            child: ListView.builder(
              itemCount: searchuserlist!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    // log(provider.user.toString());
                    final userprofile = await UserProvider.getuserProfile(
                        searchuserlist![index].username.toString());

                    final searchRepoList = await RepoProvider.getRepo(
                        searchuserlist![index].username.toString());

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          //username: searchuserlist![index].username!,
                          repoList: searchRepoList,
                          userprofile: userprofile),
                    ));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        searchuserlist![index].imageUrl.toString()),
                  ),
                  title: Text(searchuserlist![index].username.toString()),
                  trailing: Text(
                      'Repo : ${searchuserlist![index].publicRepo.toString()}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
