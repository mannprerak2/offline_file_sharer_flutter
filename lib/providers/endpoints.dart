import 'package:flutter/foundation.dart';

class Endpoints extends ChangeNotifier {
  List<ExternalUser> externalUsers = [];

  void addUser(String id, String nickName) {
    externalUsers.add(ExternalUser(id, nickName));
    notifyListeners();
  }

  void removeUser(String id) {
    externalUsers.removeWhere((e) {
      return e.endpointId == id;
    });
    notifyListeners();
  }

  void clear() {
    externalUsers.clear();
    notifyListeners();
  }
}

class ExternalUser {
  String nickName;
  String endpointId;

  ExternalUser(this.endpointId, this.nickName);
}
