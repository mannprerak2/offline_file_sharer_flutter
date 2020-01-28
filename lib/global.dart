import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/screens/home_screen.dart';
import 'package:flutter_file_sharer/screens/receive_screen.dart';
import 'package:flutter_file_sharer/screens/receiver_transfer_screen.dart';
import 'package:flutter_file_sharer/screens/send_screen.dart';
import 'package:flutter_file_sharer/screens/splash_screen.dart';
import 'package:flutter_file_sharer/screens/sender_transfer_screen.dart';
import 'package:provider/provider.dart';

class Router {
  /// starting screen
  static const splash = "/";

  /// practical root of application
  static const home = "/home";
  static const send = "/send";
  static const receive = "/receive";

  /// send string [endpointId] as argument
  static const senderTransfer = "/senderTransfer";
  static const receiverTransfer = "/receiverTransfer";

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
      case Router.senderTransfer:
        assert(s.arguments != null && s.arguments is String);
        return MaterialPageRoute(
            builder: (_) => SenderTransferScreen(s.arguments as String));
      case Router.receiverTransfer:
        return MaterialPageRoute(
            builder: (_) => ReceiverTransferScreen());
      default:
        return null;
    }
  }
}

/// get value from Providers without listening
T getP<T>() {
  return Provider.of<T>(Router.navigator.context, listen: false);
}

const serviceId = "com.pkmnapps.flutter_file_sharer";
