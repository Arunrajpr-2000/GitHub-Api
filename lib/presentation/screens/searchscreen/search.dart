import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_api/core/const.dart';
import 'package:github_api/model/user_model.dart';
import 'package:github_api/presentation/screens/Userscreen/user_profile.dart';
import 'package:github_api/providers/user_providers.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
    provider.getUserProfile('Arunrajpr-2000');
  }

  TextEditingController controller = TextEditingController();
  //provider.getUserProfile('');
  // getuser(String username) {
  //   provider.getUserProfile(username);
  // }

  @override
  Widget build(BuildContext context) {
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
                controller: controller,
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
            child:
                //  ListView.builder(
                //   itemCount: 10,
                //   itemBuilder: (context, index) {
                //  return
                ListTile(
              onTap: () {
                log(provider.user.toString());
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    username: provider.user!.username.toString(),
                    userprofile: UserModel(
                        username: provider.user!.username,
                        imageUrl: provider.user!.imageUrl,
                        bio: provider.user!.bio,
                        email: provider.user!.email,
                        location: provider.user!.location,
                        joiningDate: provider.user!.joiningDate,
                        followers: provider.user!.followers,
                        followings: provider.user!.followings,
                        publicRepo: provider.user!.publicRepo),
                  ),
                ));
              },
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(provider.user!.imageUrl.toString()),
              ),
              title: Text(provider.user!.username.toString()),
              trailing: Text('Repo : ${provider.user!.publicRepo.toString()}'),
            ),
            //   },
            // ),
          )
        ],
      ),
    );
  }
}
