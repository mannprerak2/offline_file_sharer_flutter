import 'dart:math' show Random, pi;

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        getPrefsAndPushHome();
      }
    });
    animationController.forward();
  }

  void getPrefsAndPushHome() async {
    var pref = await Prefs.getPrefs();
    getP<User>().nickName = pref.getString(Prefs.nickName) ??
        "User_" + Random().nextInt(1000).toString();
    Navigator.of(context).pushReplacementNamed(Router.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CircularRevealAnimation(
        animation: animation,
        centerAlignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
              startAngle: 0,
              endAngle: 2 * pi,
              transform: GradientRotation(-pi / 5),
              colors: <Color>[
                Colors.blue[900],
                Colors.indigo[900],
                Colors.blue[900],
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Nearby-\n-Sharer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black,
                      ),
                    ],
                    fontFamily: 'DancingScript',
                    color: Colors.white,
                    fontSize: 70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
