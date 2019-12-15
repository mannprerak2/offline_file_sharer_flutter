import 'package:flutter/widgets.dart';

class Router {
  static const home = "/home";
  static const splash = "/";
  static const send = "/send";
  static const transfer = "/transfer";
  static const receive = "/receive";

  static var navKey = GlobalKey<NavigatorState>();
  
  static var navigator = navKey.currentState;
}
