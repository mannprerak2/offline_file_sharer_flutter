import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String _nickName;

  User(this._nickName);

  String get nickName {
    return _nickName;
  }

  set nickName(String s) {
    _nickName = s;
    notifyListeners();
  }

  @override
  String toString() => _nickName;
}
