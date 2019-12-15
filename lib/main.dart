import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:flutter_file_sharer/routes.dart';
import 'package:flutter_file_sharer/screens/home_screen.dart';
import 'package:flutter_file_sharer/screens/receive_screen.dart';
import 'package:flutter_file_sharer/screens/send_screen.dart';
import 'package:flutter_file_sharer/screens/splash_screen.dart';
import 'package:flutter_file_sharer/screens/transfer_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();
  MyApp.forDesignTime();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User("User_" + Random().nextInt(1000).toString()),
        ),
      ],
      child: MaterialApp(
        title: 'Nearby Sharer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: Router.navKey,
        initialRoute: Router.splash,
        onGenerateRoute: routes,
      ),
    );
  }

  Route<dynamic> routes(RouteSettings s) {
    switch (s.name) {
      case Router.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Router.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Router.send:
        return MaterialPageRoute(builder: (_) => SendScreen());
      case Router.receive:
        return MaterialPageRoute(builder: (_) => ReceiveScreen());
      case Router.transfer:
        return MaterialPageRoute(builder: (_) => TransferScreen());
      default:
        return null;
    }
  }
}
