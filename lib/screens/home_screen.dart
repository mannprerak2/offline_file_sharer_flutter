import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:flutter_file_sharer/routes.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          UserNameWidget(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: Text("Send"),
                onPressed: onClickSend,
              ),
              RaisedButton(
                child: Text("Receive"),
                onPressed: onClickReceive,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onClickSend() async {
    if (await _checkAndAskPermissions()) {
      Router.navigator.pushNamed(Router.send);
    }
  }

  void onClickReceive() async {
    if (await _checkAndAskPermissions()) {
      Router.navigator.pushNamed(Router.receive);
    }
  }

  /// asks for permissions if not given, returns whether or not permissions are given
  Future<bool> _checkAndAskPermissions() async {
    if (await allPermissionsGranted()) {
      return true;
    } else {
      await Nearby().askLocationPermission();
      await Nearby().askExternalStoragePermission();
    }

    return await allPermissionsGranted();
  }

  Future<bool> allPermissionsGranted() async =>
      await Nearby().checkExternalStoragePermission() &&
      await Nearby().checkLocationPermission();
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //edit the userNickName onTap
        var t = TextEditingController();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Set NickName"),
              content: TextField(
                controller: t,
                decoration: InputDecoration(hintText: "Nick Name"),
                autofocus: true,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text(
                    "Set",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (t.text.trim().isNotEmpty) {
                      Provider.of<User>(context, listen: false).nickName =
                          t.text.trim();
                      Router.navigator.pop(); // pop alertdialog
                    }
                  },
                )
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Consumer<User>(
              builder: (_, user, __) {
                return Text(
                  user.nickName,
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
            Icon(Icons.edit)
          ],
        ),
      ),
    );
  }
}
