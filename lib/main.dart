import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/routes.dart';
import 'package:flutter_file_sharer/screens/home_screen.dart';
import 'package:flutter_file_sharer/screens/recieve_screen.dart';
import 'package:flutter_file_sharer/screens/send_screen.dart';
import 'package:flutter_file_sharer/screens/splash_screen.dart';
import 'package:flutter_file_sharer/screens/transfer_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();
  MyApp.forDesignTime();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearby Sharer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: routes,
    );
  }

  Route<dynamic> routes(RouteSettings s) {
    switch (s.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.send:
        return MaterialPageRoute(builder: (_) => SendScreen());
      case Routes.recieve:
        return MaterialPageRoute(builder: (_) => RecieveScreen());
      case Routes.transfer:
        return MaterialPageRoute(builder: (_) => TransferScreen());
      default:
        return null;
    }
  }
}
