import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/screens/home_screen.dart';
import 'package:flutter_file_sharer/screens/receive_screen.dart';
import 'package:flutter_file_sharer/screens/send_screen.dart';
import 'package:flutter_file_sharer/screens/splash_screen.dart';
import 'package:flutter_file_sharer/screens/transfer_screen.dart';

class Router {
  static const home = "/home";
  static const splash = "/";
  static const send = "/send";
  static const transfer = "/transfer";
  static const receive = "/receive";

  static var navKey = GlobalKey<NavigatorState>();
  
  static var navigator = navKey.currentState;

  static Route<dynamic> routes(RouteSettings s) {
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
