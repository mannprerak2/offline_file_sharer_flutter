import 'dart:io';

import 'package:flutter/foundation.dart';

class Files extends ChangeNotifier {
  List<File> files = [];

  void add(List<File> fs) {
    files = fs;
    notifyListeners();
  }
}
