import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_api/core/const.dart';
import 'package:github_api/model/repo_model.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/providers/repo_provider.dart';
import 'package:github_api/providers/user_providers.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchInBrowser(String _url) async {
    final uri = Uri.parse(_url);

    log("uri :$uri");
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $uri');
    }
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'GitHub Searcher',
          style: TextStyle(color: Colors.black),
        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userprofile.username!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.userprofile.email ?? 'No Email',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.userprofile.location ?? 'No Location',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.userprofile.joiningDate ?? 'No Joining Date',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Followers ${widget.userprofile.followers ?? '0'}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Following ${widget.userprofile.followings ?? '0'}',
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ],
          ),
          k20height,
          Text(
            widget.userprofile.bio ?? 'No Bio',
            overflow: TextOverflow.ellipsis,
          ),
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
                    onTap: () async {
                      await _launchInBrowser(
                          searchlist[index].repoUrl.toString());
                    },
                    title: Text(searchlist[index].reponame.toString()),
                    trailing: Column(
                      children: [
                        k10height,
                        Text(
                          '${searchlist[index].forkscount.toString()} Forks',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${searchlist[index].starcount.toString()} Star',
                          overflow: TextOverflow.ellipsis,
                        )
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
