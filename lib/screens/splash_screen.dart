import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future<void>.delayed(Duration(milliseconds: 500)).then((_) {
      Navigator.of(context).pushReplacementNamed(Router.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Splash"),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
