import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getPrefsAndPushHome();
    super.initState();
  }

  void getPrefsAndPushHome() async {
    var pref = await Prefs.getPrefs();
    getP<User>().nickName = pref.getString(Prefs.nickName) ??
        "User_" + Random().nextInt(1000).toString();
    await Future<void>.delayed(Duration(milliseconds: 500));
    Navigator.of(context).pushReplacementNamed(Router.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.share),
            ],
          ),
        ),
      ),
    );
  }
}
