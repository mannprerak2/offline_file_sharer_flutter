import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/providers/endpoints.dart';
import 'package:flutter_file_sharer/providers/files.dart';
import 'package:flutter_file_sharer/providers/transfer.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User("User_" + Random().nextInt(1000).toString()),
        ),
        ChangeNotifierProvider.value(
          value: Endpoints(),
        ),
        ChangeNotifierProvider.value(
          value: Files(),
        ),
        ChangeNotifierProvider.value(
          value: Transfer(),
        ),
      ],
      child: MaterialApp(
        title: 'Nearby Sharer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: Router.navKey,
        initialRoute: Router.splash,
        onGenerateRoute: Router.routes,
      ),
    );
  }
}
