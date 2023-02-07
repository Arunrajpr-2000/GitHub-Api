import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_api/presentation/screens/searchscreen/search.dart';
import 'package:github_api/providers/user_providers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gotoSearch(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  gotoSearch(context) async {
    await Future.delayed(Duration(seconds: 2));

    final userlist = await UserProvider.getUserList("Arun");

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SearchScreen(userlist: userlist),
    ));
  }
}
